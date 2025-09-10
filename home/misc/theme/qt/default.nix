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
      style = "Darkly";
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
      darkly-qt5
      darkly
    ];
    platformTheme.name = "qtct";
    kde.settings.kdeglobals.Icons.Theme = config.gtk.iconTheme.name;
    kde.settings.dolphinrc.UiSettings.ColorScheme = "*";
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

  home.activation.genFilesKconfig = lib.hm.dag.entryBefore [ "kconfig" ] ''
    ${lib.concatMapStrings (
      x:
      let
        path = "${config.xdg.configHome}/${x}";
      in
      "[ ! -e ${path} ] && touch ${path}\n"
    ) (builtins.attrNames config.qt.kde.settings)}
  '';
}
