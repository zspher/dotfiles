{pkgs, ...}: {
  home.packages = with pkgs; [
    # utilities
    ark
    filelight
    font-manager
    (nwg-displays.override {hyprlandSupport = true;})
    pavucontrol
  ];
}
