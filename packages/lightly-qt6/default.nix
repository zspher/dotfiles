{
  kdePackages,
  extra-cmake-modules,
  fetchFromGitHub,
  lib,
  stdenv,
  cmake,
  qt6,
  lightly-boehs,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "lightly-qt6";
  version = "0.5.2-unstable-2024-10-08";

  src = fetchFromGitHub {
    owner = "Bali10050";
    repo = "Lightly";
    rev = "1feaaf29f7bc20e86e9410a4e129f6b5158abad6";
    sha256 = "sha256-UxtayqLgtFbClErjZWMBp3bBtSv31AQzP5dh3fk+d44=";
  };

  preBuild = ''
    cd ./kdecoration/config/
    make -j $NIX_BUILD_CORES
    cd ../..
  '';

  postInstall = ''
    rm $out/share/kstyle/themes/lightly.themerc
    rm $out/share/color-schemes/Lightly.colors
    ln -s "${lightly-boehs}/share/kstyle/themes" "$out/share/kstyle/themes"
    ln -s "${lightly-boehs}/share/color-schemes" "$out/share/color-schemes"
  '';

  buildInputs = [ qt6.qtbase ];

  propagatedBuildInputs = with kdePackages; [
    frameworkintegration
    kcmutils
    kcolorscheme
    kcoreaddons
    kdecoration
    kiconthemes
    kwindowsystem
  ];

  nativeBuildInputs = [
    cmake
    qt6.wrapQtAppsHook
    extra-cmake-modules
  ];

  enableParallelBuilding = true;
  outputs = [
    "out"
    "dev"
  ];

  meta = with lib; {
    description = "Fork of the Lightly breeze theme style that aims to be visually modern and minimalistic";
    mainProgram = "lightly-settings5";
    homepage = "https://github.com/boehs/Lightly";
    license = licenses.gpl2Plus;
    maintainers = [ maintainers.hikari ];
    platforms = platforms.all;
  };
})
