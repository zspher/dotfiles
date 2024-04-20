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
    colors = import ./colors.nix {variant = cfg.variant;};

    package = pkgs.catppuccin-kde.override {
      flavour = [cfg.variant];
      accents = [cfg.accent];
    };

    accent = upperFirst cfg.accent;
    variant = upperFirst cfg.variant;

    themeInfo = lib.mkMerge [
      (fromINI "${package}/share/color-schemes/Catppuccin${variant}${accent}.colors")
    ];
  in
    mkIf cfg.kde.enable {
      home.packages = [
        package
      ];

      qt.kde.settings.kdeglobals = themeInfo;
    };
}
