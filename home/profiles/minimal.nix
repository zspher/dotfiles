{...}: {
  imports = [
    ../programs/terminal
    ../programs/utils/kitty
    ../programs/utils/wakatime.nix

    ../services
    ../misc/xdg-dirs.nix
    ../misc/xdg.nix
  ];
}
