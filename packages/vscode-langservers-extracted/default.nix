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
  version = "4.10.0";

  srcs = [
    (fetchFromGitHub {
      owner = "hrsh7th";
      repo = "vscode-langservers-extracted";
      rev = "0aff7702529300ef2a65d58a09d688e719e5f91f";
      hash = "sha256-kt57Zd4acMQ2slkBldgZfhtfybKznAqolZ+6jfCHyFo=";
    })
    vscodium.src
  ];
  sourceRoot = "source";
  nativeBuildInputs = [ unzip ];

  npmDepsHash = "sha256-uJ3263YSsrSrZUQ/zQeigAe1NBXyPAblmQ3v9CYb6Dc=";

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
