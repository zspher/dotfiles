{
  stdenvNoCC,
  ms-dotnettools,
}:
stdenvNoCC.mkDerivation {
  pname = "csharp-tools";
  version = "0.1";

  src = ./.;

  buildInputs = [
    ms-dotnettools
  ];

  installPhase =
    let
      root = "${ms-dotnettools}/share/vscode/extensions/ms-dotnettools.csharp";
    in
    ''
      runHook preInstall

      mkdir -p $out/bin
      mkdir -p $out/lib

      ln -s ${root}/.roslyn/Microsoft.CodeAnalysis.LanguageServer $out/bin/roslyn-ls

      runHook postInstall
    '';
}
