{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "catppuccin-obs";
  version = "unstable-2024-04-03";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "obs";
    rev = "e7c4fcf387415a20cb747121bc0416c4c8ae3362";
    hash = "sha256-dZcgIPMa1AUFXcMPT99YUUhvxHbniv0Anbh9/DB00NY=";
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
    license = licenses.mit;
    platforms = platforms.unix;
    maintainers = with maintainers; [zspher];
  };
}
