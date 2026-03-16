{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  makeWrapper,
  xercesc,
  unzip,
  libpng12,
}:
let
  # xercesc 3.1 is required
  xercesc_3_1_4 = xercesc.overrideAttrs (prev: rec {
    version = "3.1.4";
    src = fetchurl {
      url = lib.replaceStrings [ prev.version ] [ version ] prev.src.url;
      hash = "sha256-yY7trEz4pzsJNmrTScs+8wZA56MInTYNQKPd6T9m7PY=";
    };
  });
in
stdenv.mkDerivation (finalAttrs: {
  pname = "barcode-reader-cli";
  version = "12.0.7729";
  src = fetchurl {
    url = "https://barcode-reader.inliteresearch.com/downloads/12_0_7675.ci11a/BRCLI/linux64/BarcodeReaderCLI.linux.12.0.7729.zip";
    hash = "sha256-OC1lb9f1KNWpgVpVMSsth7AWH1p5yI/tUW/nkjKHHu8=";

    # inlite seems to block "uncommon" user-agents, such as Nixpkgs's custom one.
    # 406 otherwise
    curlOptsList = [
      "--user-agent"
      "Mozilla/5.0"
    ];
  };

  nativeBuildInputs = [
    autoPatchelfHook
    makeWrapper
    unzip
  ];

  buildInputs = [
    libpng12
    xercesc_3_1_4
    stdenv.cc.cc.lib
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/barcode-reader-cli

    cp bin/BarcodeReaderCLI $out/bin
    cp bin/inlite-barcode-reader-license-agreement.pdf $out/share/barcode-reader-cli/

    runHook postInstall
  '';

  preFixup = ''
    addAutoPatchelfSearchPath "$out/lib"
  '';

  meta = {
    description = "Barcode reader for 1D and 2D codes";
    homepage = "https://barcode-reader.inliteresearch.com";
    license = lib.licenses.unfree // {
      fullName = "Inlite Barcode Reader License Agreement";
      url = "https://barcode-reader.inliteresearch.com/inlite-barcode-reader-license-agreement.php";
    };
    platforms = [ "x86_64-linux" ];
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    mainProgram = "BarcodeReaderCLI";
  };
})
