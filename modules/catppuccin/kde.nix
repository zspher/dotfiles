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

  cfg = config.catppuccin;
  importINI =
    file:
    lib.importJSON (
      pkgs.runCommand "INItoJSON" { nativeBuildInputs = [ pkgs.jc ]; } ''
        jc --ini < ${file} > $out
      ''
    );
in
{
  options.catppuccin.custom.kde = {
    enable = lib.mkEnableOption "kde integration";
  };
  config =
    let
      package = pkgs.catppuccin-kde.override {
        flavour = [ cfg.flavor ];
        accents = [ cfg.accent ];
      };

      accent = upperFirst cfg.accent;
      flavor = upperFirst cfg.flavor;

      themeInfo = lib.mkMerge [
        (importINI "${package}/share/color-schemes/Catppuccin${flavor}${accent}.colors")
        { "ColorEffects:Disabled".IntensityAmount = lib.mkForce 1; }
        { "General".Name = lib.mkForce null; }
      ];
    in
    lib.mkIf cfg.custom.kde.enable {
      home.packages = [
        package # for krita, okular
      ];
      qt.kde.settings.kdeglobals = themeInfo;
    };
}
