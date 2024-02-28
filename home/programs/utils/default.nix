{pkgs, ...}: {
  imports = [
    ./copyq.nix
    ./kitty
    ./dolphin.nix
    ./wakatime.nix
  ];
  home.packages = with pkgs; [
    ark
    filelight
    font-manager
    (nwg-displays.override {hyprlandSupport = true;})
    pavucontrol
  ];
}
