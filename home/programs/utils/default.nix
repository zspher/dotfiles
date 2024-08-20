{pkgs, ...}: {
  imports = [
    ./kitty
    ./dolphin.nix
    ./wakatime.nix
  ];
  home.packages = with pkgs; [
    ark
    brightnessctl
    gnome-pomodoro
    (nwg-displays.override {hyprlandSupport = true;})
    pavucontrol
    playerctl
    qdirstat
    wev
  ];
}
