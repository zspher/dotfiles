{pkgs, ...}: {
  imports = [
    ./copyq.nix
    ./kitty
    ./dolphin.nix
    ./wakatime.nix
  ];
  home.packages = with pkgs; [
    ark
    brightnessctl
    (nwg-displays.override {hyprlandSupport = true;})
    pavucontrol
    playerctl
    qdirstat
    wev
  ];
}
