{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:
stdenvNoCC.mkDerivation {
  pname = "sddm-corners";
  version = "unstable-2023-12-29";

  src = fetchFromGitHub {
    owner = "aczw";
    repo = "sddm-theme-corners";
    rev = "6ff0ff455261badcae36cd7d151a34479f157a3c";
    hash = "sha256-CPK3kbc8lroPU8MAeNP8JSStzDCKCvAHhj6yQ1fWKkY=";
  };

  patches = [./custom-settings.patch];

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    cp -r corners/ "$out/share/sddm/themes/sddm-corners"

    runHook postInstall
  '';

  meta = with lib; {
    description = "SDDM theme with corners";
    homepage = "https://github.com/aczw/sddm-theme-corners";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [zspher];
  };
}
