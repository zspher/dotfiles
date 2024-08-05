{pkgs, ...}: {
  # fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaMono" "Noto"];})
  ];
}
