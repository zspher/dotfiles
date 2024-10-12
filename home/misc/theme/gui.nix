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
    kde.enable = true;
    kvantum.enable = false;
    mpv.enable = true;
    obs-studio.enable = true;
    swaync.enable = true;
    vesktop.enable = true;
    walker.enable = true;
    waybar.enable = true;
  };
  gtk = {
    enable = true;

    theme =
      let
        colorVariants = if config.catppuccin.flavor == "latte" then [ "light" ] else [ "dark" ];
      in
      {
        name = "Colloid-Purple-Dark-Catppuccin";
        package = pkgs.colloid-gtk-theme.override {
          inherit colorVariants;
          themeVariants = [ "purple" ];
          sizeVariants = [ "standard" ];
          tweaks = [
            "catppuccin"
            "black"
          ];
        };
      };

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

  programs.kitty.catppuccin.enable = true;
  programs.mpv.catppuccin.enable = true;
  wayland.windowManager.hyprland.catppuccin.enable = true;
}
