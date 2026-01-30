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
  version = "4.10.1";

  srcs = [
    (fetchFromGitHub {
      owner = "zspher";
      repo = "vscode-langservers-extracted";
      tag = "v${version}";
      hash = "sha256-H0aGpbgqIEYh+T9OPubpN5/7CP2oBADT44jKu9ZrXkQ=";
    })
    vscodium.src
  ];
  sourceRoot = "source";
  nativeBuildInputs = [ unzip ];

  npmDepsHash = "sha256-4wJab6o2oKoa/KV5eRBr/bf7bRj208znnU8yHOvwppk=";

  buildPhase =
    let
      extensions = "../resources/app/extensions";
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

      cp -r ${vscode-extensions.dbaeumer.vscode-eslint}/share/vscode/extensions/dbaeumer.vscode-eslint/server/out \
      lib/eslint-language-server
    '';
}
