{
  buildNpmPackage,
  unzip,
  vscodium,
  vscode-extensions,
  fetchFromGitHub,
  ...
}:
buildNpmPackage (finalAttrs: {
  pname = "vscode-langservers-extracted";
  version = "4.10.2";

  srcs = [
    (fetchFromGitHub {
      owner = "zspher";
      repo = "vscode-langservers-extracted";
      tag = "v${finalAttrs.version}";
      hash = "sha256-eNy/zfsrGa9rvyMa81Wn632D6Lj1lsztzsmnpjm/ZjU=";
    })
    vscodium.src
  ];
  sourceRoot = "source";
  nativeBuildInputs = [ unzip ];

  npmDepsHash = "sha256-GBop0BRiN3IrSNb5dbhgCWhVLAfQtrRGZPhHcVM9AOo=";

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
})
