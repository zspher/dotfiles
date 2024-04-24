{
  lib,
  pkgs,
  ...
}: let
  data = {
    Appearance = {
      custom_palette = false;
      icon_theme = "Papirus-Dark";
      standard_dialogs = "default";
      style = "kvantum-dark";
    };

    Fonts = {
      fixed = "\"CaskaydiaMono Nerd Font Mono,10,-1,5,50,0,0,0,0,0,Regular\"";
      general = "\"Sans Serif,10,-1,5,50,0,0,0,0,0,Regular\"";
    };
  };
in {
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    kde.settings.kdeglobals.General.TerminalApplication = "kitty";
  };
  xdg.configFile."qt5ct/qt5ct.conf".text = lib.generators.toINI {} data;
  xdg.configFile."qt6ct/qt6ct.conf".text = lib.generators.toINI {} data;
}
