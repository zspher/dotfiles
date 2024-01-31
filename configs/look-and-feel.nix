{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
    ../modules/home-manager/catppuccin
  ];
  theme.catppuccin = {
    enable = true;
    kvantum.enable = true;
    anyrun.enable = true;
    kde.enable = true;
  };
  catppuccin.flavour = "mocha";
  catppuccin.accent = "mauve";
  gtk = {
    enable = true;
    catppuccin.enable = true;

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
