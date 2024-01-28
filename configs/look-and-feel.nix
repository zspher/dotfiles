{pkgs, ...}: {
  imports = [
    ../modules/home-manager/catppuccin.nix
  ];
  theme.catppuccin = {
    enable = true;
    variant = "mocha";
    accent = "mauve";
    kvantum = true;
    gtk = true;
  };
  gtk = {
    enable = true;
    font.name = "NotoSans Nerd Font";
    font.size = 10;

    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papairus";
  };
  qt = {
    enable = true;
    platformTheme = "qtct";
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.callPackage ../modules/packages/posy-cursor.nix {};
    name = "Posy_Cursor";
    size = 32;
  };
}
