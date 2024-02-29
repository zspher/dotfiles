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
    filelight
    font-manager
    nvtop
    (nwg-displays.override {hyprlandSupport = true;})
    pavucontrol
    playerctl
    wev
  ];
}
