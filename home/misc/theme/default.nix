{
  pkgs,
  config,
  self,
  ...
}: {
  imports = [
    ./qt.nix
  ];
  theme.catppuccin = {
    enable = true;
    kvantum.enable = true;
    anyrun.enable = true;
    kde.enable = true;
    waybar.enable = true;
    swaync.enable = true;
    mpv.enable = true;
    obs-studio.enable = true;
    swaylock.enable = true;
  };
  catppuccin.flavour = "mocha";
  catppuccin.accent = "mauve";
  gtk = {
    enable = true;
    catppuccin.enable = true;

    font.name = "NotoSans Nerd Font";
    font.size = 10;

    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name =
      if config.catppuccin.flavour == "latte"
      then "Papirus-Light"
      else "Papirus-Dark";

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  };
  home.pointerCursor = {
    gtk.enable = true;
    package = self.packages.${pkgs.system}.posy-cursor;
    name = "Posy_Cursor";
    size = 32;
  };

  programs.btop.catppuccin.enable = true;
  programs.kitty.catppuccin.enable = true;
  programs.lazygit.catppuccin.enable = true;
  programs.starship.catppuccin.enable = true;
  wayland.windowManager.hyprland.catppuccin.enable = true;
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
