{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # ./anyrun.nix
    # ./copyq
    # ./walker
    ./cliphist.nix
    ./hyprland
    ./rofi
    ./hypridle.nix
    ./hyprlock.nix
    ./swaync.nix
    ./swww
    ./waybar
  ];

  programs.mangohud.enable = true;

  services.network-manager-applet.enable = true;
  services.kdeconnect = {
    package = pkgs.kdePackages.kdeconnect-kde;
    enable = true;
    indicator = true;
  };
}
