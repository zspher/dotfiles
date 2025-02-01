{ pkgs, lib, ... }:
{
  imports = [
    ./walker.nix
    ./hyprland
    ./rofi
    ./hypridle.nix
    ./hyprlock.nix
    ./swaync.nix
    ./swww
    ./waybar
  ];

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
  services.kdeconnect = {
    package = pkgs.kdePackages.kdeconnect-kde;
    enable = true;
    indicator = true;
  };
  systemd.user.services = {
    kdeconnect.Unit.After = lib.mkForce [ "graphical-session.target" ];
    kdeconnect-indicator.Unit.After = lib.mkForce [ "graphical-session.target" ];
  };
}
