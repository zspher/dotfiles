{
  pkgs,
  config,
  self,
  ...
}:
{
  imports = [
    ./qt
  ];
  dconf = {
    enable = true;
    # specify dark theme for some applications: electron, gtk stuff
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };
  gtk = {
    enable = true;
    font.name = "NotoSans Nerd Font";
    font.size = 10;

    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = if config.catppuccin.flavor == "latte" then "Papirus-Light" else "Papirus-Dark";

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
  catppuccin.custom.gtk.enable = true;

  home.pointerCursor = {
    enable = true;
    dotIcons.enable = false;
    gtk.enable = true;
    package = pkgs.posy-cursors;
    name = "Posy_Cursor";
    size = 32;
  };
}
