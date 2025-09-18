{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # ./anyrun.nix
    # ./walker
    ./hyprland
    ./rofi
    ./hypridle.nix
    ./hyprlock.nix
    ./swaync.nix
    ./swww
    ./waybar
  ];

  programs.mangohud.enable = true;

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
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };

  xdg.portal = {
    xdgOpenUsePortal = true;
    config.common = {
      default = [
        "gtk"
      ];

      "org.freedesktop.impl.portal.GlobalShortcuts" = [ "hyprland" ];
      "org.freedesktop.impl.portal.InputCapture" = [ "hyprland" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
    };
  };
}
