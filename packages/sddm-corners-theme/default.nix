{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  font ? "Noto Sans",
  fontSize ? "9",
  kdePackages,
}:
stdenvNoCC.mkDerivation {
  pname = "sddm-corners";
  version = "unstable-2024-07-08";

  src = fetchFromGitHub {
    owner = "zspher";
    repo = "sddm-theme-corners";
    rev = "40f93d05c3bd0493900c7a99b304548c97952ebb";
    hash = "sha256-BW2mzN2hwpECPKTODq+KvPDcsZYPTqWX4qQIH1MoByA=";
  };

  dontWrapQtApps = true;

  propagatedBuildInputs = with kdePackages; [
    qtsvg
  ];

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${kdePackages.qtsvg} >> $out/nix-support/propagated-user-env-packages
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    cp -r corners/ "$out/share/sddm/themes/sddm-corners"

    configFile=$out/share/sddm/themes/sddm-corners/theme.conf

    substituteInPlace $configFile \
      --replace-fail 'BgSource="backgrounds/glacier.png"' 'BgSource="backgrounds/leaves.png"' \
      --replace-fail 'FontFamily="Atkinson Hyperlegible"' 'FontFamily="${font}"' \
      --replace-fail 'FontSize=9' 'FontSize=${fontSize}' \
      --replace-fail 'TimeFormat="hh:mm AP"' 'TimeFormat="HH:mm"'

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
