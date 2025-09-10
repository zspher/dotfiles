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
  catppuccin.custom = {
    # anyrun.enable = true;
    gtk.enable = true;
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
    dotIcons.enable = false;
    gtk.enable = true;
    package = self.packages.${pkgs.stdenv.hostPlatform.system}.posy-cursor;
    name = "Posy_Cursor";
    size = 32;
  };

  catppuccin.obs.enable = true;
  catppuccin.kitty.enable = true;
  catppuccin.mpv.enable = true;
  catppuccin.hyprland.enable = true;
}
