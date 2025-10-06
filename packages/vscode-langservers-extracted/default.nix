{
  buildNpmPackage,
  unzip,
  vscodium,
  vscode-extensions,
  fetchFromGitHub,
  ...
}:
buildNpmPackage {
  pname = "vscode-langservers-extracted";
  version = "4.11.0";

  srcs = [
    (fetchFromGitHub {
      owner = "zspher";
      repo = "vscode-langservers-extracted";
      rev = "369d9316e9e6c4bf38e8da72f23cf5aee83466aa";
      hash = "sha256-LXD3NQ1eJEoY4V9rCGHZM/FWxX0TSis6asUQJkfm7Yo=";
    })
    vscodium.src
  ];
  sourceRoot = "source";
  nativeBuildInputs = [ unzip ];

  npmDepsHash = "sha256-pnbZS7clblx5X3+qyUB3hes2qA76aSZJxpEe55D0EF8=";

  buildPhase =
    let
      extensions = "${vscodium}/lib/vscode/resources/app/extensions";
    in
    ''
      npx babel ${extensions}/css-language-features/server/dist/node \
        --out-dir lib/css-language-server/node/

      npx babel ${extensions}/html-language-features/server/dist/node \
        --out-dir lib/html-language-server/node/

      npx babel ${extensions}/json-language-features/server/dist/node \
        --out-dir lib/json-language-server/node/

      npx babel ${extensions}/markdown-language-features/dist \
        --out-dir lib/markdown-language-server/node/
      mv lib/markdown-language-server/node/serverWorkerMain.js lib/markdown-language-server/node/main.js

      cp -r ${vscode-extensions.dbaeumer.vscode-eslint}/share/vscode/extensions/dbaeumer.vscode-eslint/server/out \
      lib/eslint-language-server
    '';
}
