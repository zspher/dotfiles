{pkgs, ...}: {
  imports = [
    ./anyrun.nix
    ./hyprland
    ./rofi
    ./swayidle.nix
    ./hyprlock.nix
    ./swaync.nix
    ./swww
    ./waybar.nix
  ];

  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
  services.kdeconnect = {
    package = pkgs.kdePackages.kdeconnect-kde;
    enable = true;
    indicator = true;
  };
}
