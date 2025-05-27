{
  config,
  lib,
  pkgs,
  ...
}:
let
  upperFirst =
    str:
    (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);

  cfg = config.theme.catppuccin;
  ctp = {
    inherit (config.catppuccin) sources flavor accent;
  };

  importINI =
    file:
    lib.importJSON (
      pkgs.runCommand "INItoJSON" { nativeBuildInputs = [ pkgs.jc ]; } ''
        jc --ini < ${file} > $out
      ''
    );
in
{
  options.theme.catppuccin.kde = {
    enable = lib.mkEnableOption "kde integration";
  };

  config =
    let
      package = pkgs.catppuccin-kde.override {
        flavour = [ ctp.flavor ];
        accents = [ ctp.accent ];
      };

      accent = upperFirst ctp.accent;
      flavor = upperFirst ctp.flavor;

      themeInfo = lib.mkMerge [
        (importINI "${package}/share/color-schemes/Catppuccin${flavor}${accent}.colors")
        { "ColorEffects:Disabled".IntensityAmount = lib.mkForce 1; }
        { "General".Name = lib.mkForce null; }
      ];
    in
    lib.mkIf cfg.kde.enable {
      home.packages = [
        package # for krita, okular
      ];
      qt.kde.settings.kdeglobals = themeInfo;
    };
}
