{
  extra-cmake-modules,
  fetchFromGitHub,
  fetchurl,
  frameworkintegration,
  kcmutils,
  kcolorscheme,
  kcoreaddons,
  kdecoration,
  kiconthemes,
  kwindowsystem,
  lib,
  mkKdeDerivation,
}:
let
  config-tar-gz = fetchurl {
    url = "https://github.com/boehs/Lightly/files/14445309/config.tar.gz";
    sha256 = "sha256-eCIRm2z1+eTBcCCg8Wdt2DfTTbc767Rv+m1LI+t058I=";
  };
  lightlystyleconfig-json = fetchurl {
    url = "https://github.com/boehs/Lightly/files/14444935/lightlystyleconfig.json";
    sha256 = "sha256-ORQk0QirDB9dF3RdgmH5sstqQqqSEfOE6lh1YEUz+iM=";
  };
in
mkKdeDerivation {
  pname = "lightly-qt6";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "boehs";
    repo = "Lightly";
    rev = "00ca23447844114d41bfc0d37cf8823202c082e8";
    sha256 = "sha256-NpgOcN9sDqgQMjqcfx92bfKohxaJpnwMgxb9MCu9uJM=";
  };

  patchPhase = ''
    mkdir tmp
    tar -xv -f ${config-tar-gz} -C tmp

    cp -v tmp/config/CMakeLists.txt kdecoration/config/CMakeLists.txt
    cp -v tmp/config/kcm_lightlydecoration.json kdecoration/config/kcm_lightlydecoration.json
    cp -v tmp/config/kcm_lightlydecoration.cpp kdecoration/config/kcm_lightlydecoration.cpp
    cp -v ${lightlystyleconfig-json} kstyle/config/lightlystyleconfig.json
  '';

  postInstall = ''
    rm $out/share/kstyle/themes/lightly.themerc
  '';

  extraPropagatedBuildInputs = [
    frameworkintegration
    kcolorscheme
    kcoreaddons
    kdecoration
    kiconthemes
    kwindowsystem
    kcmutils
  ];

  extraNativeBuildInputs = [
    extra-cmake-modules
  ];

  meta = with lib; {
    description = "Fork of the Lightly breeze theme style that aims to be visually modern and minimalistic";
    mainProgram = "lightly-settings5";
    homepage = "https://github.com/boehs/Lightly";
    license = licenses.gpl2Plus;
    maintainers = [ maintainers.hikari ];
    platforms = platforms.all;
  };
}
