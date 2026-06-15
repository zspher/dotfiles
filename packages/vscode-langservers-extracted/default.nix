{
  stdenv,
  buildNpmPackage,
  unzip,
  vscodium,
  vscode-extensions,
  fetchFromGitHub,
  ...
}:
buildNpmPackage (finalAttrs: {
  pname = "vscode-langservers-extracted";
  version = "4.10.3";

  __structuredAttrs = true;

  srcs = [
    (fetchFromGitHub {
      owner = "zspher";
      repo = "vscode-langservers-extracted";
      tag = "v${finalAttrs.version}";
      hash = "sha256-X4MsG5AV5/XvHCVbdukd/zVuBVfOVOf2fGZrZc9WdRU=";
    })
    vscodium.src
  ];
  sourceRoot = "source";
  nativeBuildInputs = [ unzip ];

  npmDepsHash = "sha256-abtR9sRzzLoXGIwpWAzs7lfFJlUiysNPKG8bux9WxGI=";

  buildPhase =
    let
      extensions =
        if stdenv.hostPlatform.isDarwin then
          "../VSCodium.app/Contents/Resources/app/extensions"
        else
          "../resources/app/extensions";
    in
    ''
      mkdir -p lib/{css,html,json,markdown}-language-server
      cp -r ${extensions}/markdown-language-features/dist lib/markdown-language-server/node/
      cp -r ${extensions}/css-language-features/server/dist/node lib/css-language-server/node
      cp -r ${extensions}/html-language-features/server/dist/node lib/html-language-server/node
      cp -r ${extensions}/json-language-features/server/dist/node lib/json-language-server/node

      cp -r ${vscode-extensions.dbaeumer.vscode-eslint}/share/vscode/extensions/dbaeumer.vscode-eslint/server/out \
      lib/eslint-language-server
    '';
})
