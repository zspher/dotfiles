{pkgs, ...}: {
  imports = [
    ./anyrun.nix
    ./walker.nix
    ./hyprland
    ./rofi
    ./swayidle.nix
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
}
