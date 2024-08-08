{
  pkgs,
  config,
  self,
  ...
}: {
  imports = [
    ./qt
  ];
  theme.catppuccin = {
    enable = true;
    anyrun.enable = true;
    kde.enable = true;
    kvantum.enable = false;
    mpv.enable = true;
    obs-studio.enable = true;
    swaync.enable = true;
    waybar.enable = true;
    webcord.enable = true;
  };
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";
  gtk = {
    enable = true;

    theme = let
      colorVariants =
        if config.catppuccin.flavor == "latte"
        then ["light"]
        else ["dark"];
    in {
      name = "Colloid-Purple-Dark-Catppuccin";
      package = pkgs.colloid-gtk-theme.override {
        inherit colorVariants;
        themeVariants = ["purple"];
        sizeVariants = ["standard"];
        tweaks = ["catppuccin" "black"];
      };
    };

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

  programs.bat.catppuccin.enable = true;
  programs.btop.catppuccin.enable = true;
  programs.fish.catppuccin.enable = true;
  programs.fzf.catppuccin.enable = true;
  programs.kitty.catppuccin.enable = true;
  programs.lazygit.catppuccin.enable = true;
  programs.mpv.catppuccin.enable = true;
  programs.starship.catppuccin.enable = true;
  programs.tmux.catppuccin.enable = true;
  wayland.windowManager.hyprland.catppuccin.enable = true;

  home.sessionVariables = {
    GREP_COLORS = "ms=01;31";
  };

  programs.vivid = {
    enable = true;
    theme = "catppuccin-${config.catppuccin.flavor}";
  };
}
