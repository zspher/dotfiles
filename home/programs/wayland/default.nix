{...}: {
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
    enable = true;
    indicator = true;
  };
}
