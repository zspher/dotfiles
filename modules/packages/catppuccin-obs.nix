{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-obs";
  version = "unstable-2023-07-06";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "obs";
    rev = "9a78d89d186afbdcc719a1cb7bbf7fb1c2fdd248";
    hash = "sha256-8DjAjpYsC9lEHe6gt/B7YCyfqVPaA5Qg1hbIMyyx/ho=";
  };

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r themes "$out/themes"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Soothing pastel theme for obs-studio";
    homepage = "https://github.com/catppuccin/obs";
    platforms = platforms.unix;
    maintainers = with maintainers; [zspher];
  };
}
