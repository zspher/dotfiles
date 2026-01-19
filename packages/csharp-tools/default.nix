{
  stdenvNoCC,
  ms-dotnettools,
  makeWrapper,
  nodejs,
  vscode,
}:
stdenvNoCC.mkDerivation {
  pname = "csharp-tools";
  version = "0.1";

  src = ./.;

  nativeBuildInputs = [
    vscode
  ];

  buildInputs = [
    ms-dotnettools
    makeWrapper
    nodejs
  ];

  installPhase =
    let
      root = "${ms-dotnettools}/share/vscode/extensions/ms-dotnettools.csharp";
    in
    ''
      runHook preInstall

      mkdir -p $out/bin
      mkdir -p $out/lib
      mkdir -p $out/share

      ln -s ${root}/.roslyn/Microsoft.CodeAnalysis.LanguageServer $out/bin/roslyn-ls

      ln -s ${root}/.debugger/vsdbg-ui $out/bin/vsdbg-ui
      cp $src/vsdbgsignature.js $out/share

      cp "${vscode}/lib/vscode/resources/app/node_modules/vsda/build/Release/vsda.node" $out/share

      substituteInPlace $out/share/vsdbgsignature.js \
        --replace-fail "vsda.node" "$out/share/vsda.node"

      makeWrapper "${nodejs}/bin/node" "$out/bin/vsdbgsignature" --add-flags "$out/share/vsdbgsignature.js"

      runHook postInstall
    '';
}
