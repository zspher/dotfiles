{
  lib,
  pkgs,
  self,
  config,
  inputs,
  ...
}:
let
  data = qtctVersion: {
    Appearance = {
      custom_palette = true;
      icon_theme = config.gtk.iconTheme.name;
      standard_dialogs = "xdgdesktopportal";
      style = if qtctVersion == "qt5ct" then "kvantum-dark" else "Darkly";
      color_scheme_path = "${config.xdg.configHome}/${qtctVersion}/colors/catppuccin.conf";
    };

    Fonts = {
      fixed = "\"CaskaydiaMono Nerd Font Mono,10,-1,5,50,0,0,0,0,0,Regular\"";
      general = "\"Sans Serif,10,-1,5,50,0,0,0,0,0,Regular\"";
    };
  };
in
{
  catppuccin.custom.kde.enable = true;
  qt = {
    enable = true;
    style.package = with pkgs; [
      libsForQt5.qtstyleplugin-kvantum # for keepassxc, masterpdfeditor4
      darkly
    ];
    kvantum =
      let
        accent = config.catppuccin.accent;
        variant = config.catppuccin.flavor;
      in
      {
        enable = true;
        settings.General.theme = "catppuccin-${variant}-${accent}";
        themes = [
          (pkgs.catppuccin-kvantum.override { inherit accent variant; })
        ];
      };
    platformTheme.name = "qtct";
    kde.settings.kdeglobals.Icons.Theme = config.gtk.iconTheme.name;
  };

  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = lib.generators.toINI { } (data "qt5ct");
    "qt6ct/qt6ct.conf".text = lib.generators.toINI { } (data "qt6ct");
    "qt6ct/colors/catppuccin.conf".source = ./qt6ct-catppuccin.conf;
    "qt5ct/colors/catppuccin.conf".source = ./qt6ct-catppuccin.conf;
    "darklyrc".text = ''
      [Style]
      AnimationsEnabled=false
      DolphinSidebarOpacity=100
      MenuOpacity=100
      TransparentDolphinView=false
    '';
  };
}
