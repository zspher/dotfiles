{
  stdenvNoCC,
  vscode-extensions,
}:
stdenvNoCC.mkDerivation {
  pname = "csharp-devkit-wrapper";
  version = "0.1";

  src = ./.;

  buildInputs = [
    vscode-extensions.ms-dotnettools.csharp
  ];

  installPhase =
    let
      root = "${vscode-extensions.ms-dotnettools.csharp}/share/vscode/extensions/ms-dotnettools.csharp";
    in
    ''
      runHook preInstall

      mkdir -p $out/bin
      mkdir -p $out/lib

      ln -s ${root}/.roslyn/Microsoft.CodeAnalysis.LanguageServer $out/bin/roslyn-ls
      ln -s ${root}/.razor/rzls $out/bin/rzls

      runHook postInstall
    '';
}
