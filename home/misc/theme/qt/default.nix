{
  lib,
  pkgs,
  self,
  config,
  ...
}:
let
  data = qtVersion: {
    Appearance = {
      custom_palette = true;
      icon_theme = config.gtk.iconTheme.name;
      standard_dialogs = "default";
      style = "Lightly";
      color_scheme_path = "${config.xdg.configHome}/${qtVersion}/colors/catppuccin.conf";
    };

    Fonts = {
      fixed = "\"CaskaydiaMono Nerd Font Mono,10,-1,5,50,0,0,0,0,0,Regular\"";
      general = "\"Sans Serif,10,-1,5,50,0,0,0,0,0,Regular\"";
    };
  };
in
{
  qt = {
    enable = true;
    style.package = with pkgs; [
      lightly-boehs
      self.packages.${pkgs.system}.lightly-qt6
    ];
    platformTheme.name = "qtct";
    kde.settings.kdeglobals.General.TerminalApplication = "kitty";
    kde.settings.kdeglobals.Icons.Theme = config.gtk.iconTheme.name;
  };

  # BUG: https://github.com/NixOS/nixpkgs/pull/349457
  #      https://github.com/NixOS/nixpkgs/issues/350514
  #      waiting for staging-next
  home.sessionVariables.QT_PLUGIN_PATH =
    let
      deferTheme =
        themes:
        map (
          theme:
          pkgs.runCommand "${pkgs.lib.getName theme}-workaround" { } ''
            plugins="${theme.outPath}/${pkgs.qt6.qtbase.qtPluginPrefix}"
            cp -r --dereference "$plugins" $out
          ''
        ) themes;

      toStr = lib.concatMapStrings (x: ":" + x) (
        deferTheme (
          with pkgs;
          [
            self.packages.${pkgs.system}.lightly-qt6
            qt6ct
          ]
        )
      );
    in
    "$QT_PLUGIN_PATH${toStr}";

  xdg.configFile = {
    "qt5ct/qt5ct.conf".text = lib.generators.toINI { } (data "qt5ct");
    "qt6ct/qt6ct.conf".text = lib.generators.toINI { } (data "qt6ct");
    "qt6ct/colors/catppuccin.conf".source = ./qt6ct-catppuccin.conf;
    "qt5ct/colors/catppuccin.conf".source = ./qt5ct-catppuccin.conf;
    "lightlyrc".text = ''
      [Style]
      AnimationsEnabled=false
      DolphinSidebarOpacity=100
      MenuOpacity=100
      TransparentDolphinView=false
    '';
  };

  home.activation.genKdeglobals = lib.hm.dag.entryBefore [ "kconfig" ] ''
    touch ${config.xdg.configHome}/kdeglobals
  '';
}
