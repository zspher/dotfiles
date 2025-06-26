{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  rofi-unwrapped,
  libqalculate,
  glib,
  cairo,
  gobject-introspection,
  wrapGAppsHook3,
  meson,
  ninja,
}:

stdenv.mkDerivation rec {
  pname = "rofi-calc";
  version = "2.4.0";

  src = fetchFromGitHub {
    owner = "svenstaro";
    repo = "rofi-calc";
    rev = "de74761191105d2c4aa96a25de091836abb2ce83";
    sha256 = "sha256-yTh2rYcldwsjChc0aIwKIsyF+6PxqnNwwbJ/KrAPn8k=";
  };

  nativeBuildInputs = [
    pkg-config
    gobject-introspection
    wrapGAppsHook3
    meson
    ninja
  ];

  buildInputs = [
    rofi-unwrapped
    libqalculate
    glib
    cairo
  ];

  postPatch = ''
    substituteInPlace src/calc.c --replace-fail \
      "qalc_binary = \"qalc\"" \
      "qalc_binary = \"${libqalculate}/bin/qalc\""

    substituteInPlace src/meson.build --replace-fail \
      "rofi.get_variable('pluginsdir')" \
      "'$out/lib/rofi'"
  '';

  meta = with lib; {
    description = "Do live calculations in rofi!";
    homepage = "https://github.com/svenstaro/rofi-calc";
    license = licenses.mit;
    maintainers = with maintainers; [ albakham ];
    platforms = with platforms; linux;
  };
}
