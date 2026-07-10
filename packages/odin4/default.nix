{
  stdenv,
  fetchFromGitHub,
  cmake,
  pkg-config,
  cryptopp,
  libusb1,
  qt6,
  lib,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "odin4";
  version = "7.3.0";

  src = fetchFromGitHub {
    owner = "Llucs";
    repo = "odin4";
    rev = "v${finalAttrs.version}";
    hash = "sha256-HJeZbGxnbVL7Mxq72ejABBMbJsCA78HM1RcSWcqlfIA=";
  };

  outputs = [
    "out"
    "udev"
  ];

  strictDeps = true;
  __structuredAttrs = true;

  patches = [
    ./fix-stuff.patch
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    qt6.wrapQtAppsHook
  ];

  buildInputs = [
    cryptopp
    libusb1
    qt6.qtbase
  ];
  cmakeFlags = [
    (lib.cmakeBool "ODIN4_BUILD_TESTS" false)
    (lib.cmakeBool "ODIN4_BUILD_GUI" false)
  ];

  preInstall = ''
    mkdir -p $udev/lib/udev/rules.d
    install -m644 -t $udev/lib/udev/rules.d $src/udev/60-odin4.rules
  '';
})
