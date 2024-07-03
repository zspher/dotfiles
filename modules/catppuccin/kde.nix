{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  veryBigNum = 100000;
  upperFirst = str: (lib.strings.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 veryBigNum str);

  cfg = config.theme.catppuccin;
  ctp = {inherit (config.catppuccin) sources flavor accent;};

  fromINI = file: let
    inherit (builtins) fromJSON readFile;

    # convert to json
    json = with pkgs;
      runCommand "converted.json" {} ''
        ${pkgs.jc}/bin/jc --ini < ${file} > $out
      '';
  in
    fromJSON (readFile json);
in {
  options.theme.catppuccin.kde = {
    enable = mkEnableOption "kde integration";
  };

  config = let
    package = pkgs.catppuccin-kde.override {
      flavour = [ctp.flavor];
      accents = [ctp.accent];
    };

    accent = upperFirst ctp.accent;
    flavor = upperFirst ctp.flavor;

    themeInfo = lib.mkMerge [
      (fromINI "${package}/share/color-schemes/Catppuccin${flavor}${accent}.colors")
      {"ColorEffects:Disabled".IntensityAmount = lib.mkForce 1;}
    ];
  in
    mkIf cfg.kde.enable {
      home.packages = [
        package
      ];

      qt.kde.settings.kdeglobals = themeInfo;
    };
}
