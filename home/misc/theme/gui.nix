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
  theme.catppuccin = {
    enable = true;
    gtk.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
    rofi.enable = true;
    swaync.enable = true;
    vesktop.enable = true;
    walker.enable = true;
    waybar.enable = true;
  };
  gtk = {
    font.name = "NotoSans Nerd Font";
    font.size = 10;

    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name = if config.catppuccin.flavor == "latte" then "Papirus-Light" else "Papirus-Dark";

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = self.packages.${pkgs.system}.posy-cursor;
    name = "Posy_Cursor";
    size = 32;
  };

  catppuccin.obs.enable = true;
  catppuccin.kitty.enable = true;
  catppuccin.mpv.enable = true;
  catppuccin.hyprland.enable = true;
}
