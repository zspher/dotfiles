{
  pkgs,
  config,
  ...
}: {
  imports = [
    ../modules/home-manager/catppuccin.nix
  ];
  theme.catppuccin = {
    enable = true;
    variant = "mocha";
    accent = "mauve";
    kvantum.enable = true;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    font.name = "NotoSans Nerd Font";
    font.size = 10;

    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = "Papirus-Dark";

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
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
  #programs.qtct = {
  #  enable = true;
  #  iconTheme.package = pkgs.papairus-icon-theme;
  #  iconTheme.name = "Papirus-Dark";
  #  font.name = "NotoSans Nerd Font";
  #  font.size = "10";
  #  fontMono.name = "";
  #  fontMono.size = "";
  #};
}
