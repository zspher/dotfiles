import os
import select
import signal
import socket
import subprocess
import sys
import tempfile


def main() -> int:
    lib_dir = os.path.join(sys.argv[1], "lib")
    if not os.path.isdir(lib_dir):
        print(
            f"Gradle extension lib directory does not exist: {lib_dir}", file=sys.stderr
        )
        return 1

    listener = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
    server = None
    socket_path = None

    try:
        bind_error = None
        for runtime_dir in (os.environ.get("XDG_RUNTIME_DIR"), tempfile.gettempdir()):
            if not runtime_dir:
                continue

            fd, candidate_path = tempfile.mkstemp(
                prefix="gradle-language-server-", suffix=".sock", dir=runtime_dir
            )
            os.close(fd)
            os.unlink(candidate_path)

            try:
                listener.bind(candidate_path)
                socket_path = candidate_path
                break
            except OSError as err:
                bind_error = err
                socket_path = None
        else:
            print(
                f"Could not create Gradle language server socket: {bind_error}",
                file=sys.stderr,
            )
            return 1

        listener.listen(1)
        java = str(sys.argv[2])
        server = subprocess.Popen(
            [
                os.path.join(java, "bin", "java"),
                "-cp",
                os.path.join(lib_dir, "*"),
                "com.microsoft.gradle.GradleLanguageServer",
                socket_path,
            ],
            stdin=subprocess.DEVNULL,
        )

        conn, _ = listener.accept()
        listener.close()

        stdin_fd = sys.stdin.buffer.fileno()
        stdout = sys.stdout.buffer
        conn_fd = conn.fileno()
        watch_stdin = True

        while True:
            read_fds = [conn_fd]
            if watch_stdin:
                read_fds.append(stdin_fd)

            readable, _, _ = select.select(read_fds, [], [])

            if stdin_fd in readable:
                data = os.read(stdin_fd, 65536)
                if not data:
                    watch_stdin = False
                    try:
                        conn.shutdown(socket.SHUT_WR)
                    except OSError:
                        pass
                else:
                    conn.sendall(data)

            if conn_fd in readable:
                data = conn.recv(65536)
                if not data:
                    break
                stdout.write(data)
                stdout.flush()

        return server.wait()
    finally:
        if server and server.poll() is None:
            server.send_signal(signal.SIGTERM)
            try:
                server.wait(timeout=2)
            except subprocess.TimeoutExpired:
                server.kill()
        try:
            listener.close()
        except OSError:
            pass
        if socket_path:
            try:
                os.unlink(socket_path)
            except OSError:
                pass


if __name__ == "__main__":
    raise SystemExit(main())
