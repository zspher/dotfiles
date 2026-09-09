{
  makeWrapper,
  stdenvNoCC,
  vscode-extensions,
  vscode-gradle ? vscode-extensions.vscjava.vscode-gradle,
  writers,
  jdk_headless,
  jre_minimal,
}:

let
  jre = jre_minimal.override {
    modules = [
      "java.base"
      "java.logging"
      "java.xml"
      "jdk.crypto.ec"
    ];
    jdk = jdk_headless;
  };
  bridge = writers.writePython3Bin "gradle-lsp-bridge" {
    flakeIgnore = [
      "E501"
    ];
  } (builtins.readFile ./bridge.py);
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "gradle-language-server";
  version = "3.18.0";
  __structuredAttrs = true;

  src = ./.;

  nativeBuildInputs = [
    makeWrapper
  ];

  buildInputs = [
    bridge
    jre
    vscode-gradle
  ];

  installPhase = ''
    mkdir -p $out/bin

    makeWrapper ${bridge}/bin/gradle-lsp-bridge $out/bin/gradle-language-server \
      --add-flags "'${vscode-gradle}/share/vscode/extensions/vscjava.vscode-gradle/' ${jdk_headless}"
  '';
})
