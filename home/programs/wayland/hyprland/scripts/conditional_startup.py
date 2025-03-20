import datetime
import subprocess

now = datetime.datetime.now().time()

limit = now.replace(10, 0, 0, 0)

if now < limit:
    subprocess.Popen(
        ["obsidian"],
        start_new_session=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )
