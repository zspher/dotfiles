{
  pkgs,
  config,
  self,
  lib,
  ...
}: let
  upperFirst = str:
    (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);
in {
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
  };
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";
  gtk = {
    enable = true;
    catppuccin.enable = true;

    # theme = let
    #   gtkTheme =
    #     if config.catppuccin.flavor == "latte"
    #     then "light"
    #     else "dark";
    # in {
    #   name = "Colloid-Purple-Dark-Catppuccin";
    #   package = pkgs.colloid-gtk-theme.override {
    #     themeVariants = ["purple"];
    #     colorVariants = [gtkTheme];
    #     sizeVariants = ["standard"];
    #     tweaks = ["catppuccin" "black"];
    #   };
    # };

    font.name = "NotoSans Nerd Font";
    font.size = 10;

    iconTheme.package = pkgs.papirus-icon-theme;
    iconTheme.name =
      if config.catppuccin.flavor == "latte"
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
  programs.tmux.catppuccin.enable = true;
  wayland.windowManager.hyprland.catppuccin.enable = true;

  home.sessionVariables = {
    GREP_COLORS = "ms=01;31";
  };
}
