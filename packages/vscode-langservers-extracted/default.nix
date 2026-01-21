{
  buildNpmPackage,
  unzip,
  vscodium,
  vscode-extensions,
  fetchFromGitHub,
  ...
}:
buildNpmPackage rec {
  pname = "vscode-langservers-extracted";
  version = "4.10.7";

  srcs = [
    (fetchFromGitHub {
      owner = "zed-industries";
      repo = "vscode-langservers-extracted";
      tag = "v${version}";
      hash = "sha256-VpCifcSg7H6d03c/BPeW1bHd7xxGff/V3P4pctcJmDY=";
    })
    vscodium.src
  ];
  sourceRoot = "source";
  nativeBuildInputs = [ unzip ];

  npmDepsHash = "sha256-G4KROyE0OPdDCEEcZOvQbM/h7PDaBCkrlOrGIoUJ1TY=";

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
