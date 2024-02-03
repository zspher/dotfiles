{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.theme.catppuccin;

  veryBigNum = 100000;
  upperFirst = str: (lib.strings.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 veryBigNum str);
in {
  imports = [
    ./kde.nix
  ];
  options.theme.catppuccin = {
    enable = mkEnableOption "catppuccin";
    package = mkOption {
      type = types.package;
      default = pkgs.catppuccin;
      defaultText = literalExpression "pkgs.catppuccin";
      description = "The package to use for catppuccin theme";
    };
    finalPackage = mkOption {
      type = types.package;
      readOnly = true;
      description = "Resulting catppuccin variant";
      default = cfg.package.override {
        accent = cfg.accent;
        variant = cfg.variant;
      };
    };
    variant = mkOption {
      type = types.enum ["latte" "frappe" "macchiato" "mocha"];
      default = config.catppuccin.flavour;
      description = "Sets catppuccin theme variant";
    };
    type = mkOption {
      type = types.enum ["dark" "light"];
      readOnly = true;
      description = "ligth or dark theme";
    };
    accent = mkOption {
      type = types.enum [
        "rosewater"
        "flamingo"
        "pink"
        "mauve"
        "red"
        "maroon"
        "peach"
        "yellow"
        "green"
        "teal"
        "sky"
        "sapphire"
        "blue"
        "lavender"
      ];
      default = config.catppuccin.accent;
      description = "Main accent to use for catppuccin";
    };

    kvantum.enable = mkEnableOption "kvantum integration";
    anyrun.enable = mkEnableOption "anyrun integration";
    waybar.enable = mkEnableOption "waybar integration";
    swaync.enable = mkEnableOption "swaync integration";
    mpv.enable = mkEnableOption "mpv integration";
    obs-studio.enable = mkEnableOption "obs-studio integration";
  };

  config = let
    catppuccin-obs = pkgs.callPackage ../../packages/catppuccin-obs.nix {};
    kvantum-theme = "Catppuccin-${upperFirst cfg.variant}-${upperFirst cfg.accent}";
    colors = import ./colors.nix {variant = cfg.variant;};

    replaceColors = src:
      builtins.readFile (pkgs.substitute {
        src = src;
        replacements = builtins.concatMap (x: ["--replace" "#{{${x}}}" "#${colors.${x}}"]) (builtins.attrNames colors);
      });
  in
    mkIf cfg.enable (
      mkMerge [
        {
          theme.catppuccin.type = (
            if builtins.elem cfg.variant ["frappe" "macchiato" "mocha"]
            then "dark"
            else "light"
          );

          home.packages = [cfg.finalPackage];
        }

        (mkIf cfg.kvantum.enable {
          qt = {
            style.name = "kvantum";
          };
          xdg.configFile."Kvantum/kvantum.kvconfig".text = generators.toINI {} {
            General.theme = "${kvantum-theme}#";
          };
          xdg.configFile."Kvantum/${kvantum-theme}#/${kvantum-theme}#.kvconfig".source = "${cfg.finalPackage}/share/Kvantum/${kvantum-theme}/${kvantum-theme}.kvconfig";
          #xdg.configFile."Kvantum/${kvantum-theme}#/${kvantum-theme}#.kvconfig".source = pkgs.substitute {
          #  src = "${cfg.finalPackage}/share/Kvantum/${kvantum-theme}/${kvantum-theme}.kvconfig";
          #  replacements = ["--replace" "translucent_windows=false" "translucent_windows=true"];
          #};
        })

        (mkIf (cfg.anyrun.enable && config.programs.anyrun.enable) {
          programs.anyrun.extraCss = replaceColors ./anyrun-template.css;
        })
        (mkIf (cfg.waybar.enable && config.programs.waybar.enable) {
          programs.waybar.style = replaceColors ./waybar-template.css;
        })
        (mkIf (cfg.swaync.enable && config.programs.swaync.enable) {
          programs.swaync.style = replaceColors ./swaync-template.css;
        })
        (mkIf (cfg.mpv.enable && config.programs.mpv.enable) {
          programs.mpv.scriptOpts.uosc = {
            chapter_ranges = lib.concatStrings [
              "intros:${colors.blue},"
              "outros:${colors.blue},"
              "openings:${colors.blue},"
              "endings:${colors.blue},"
              "ads:${colors.red}"
            ];
            color = lib.concatStrings [
              "foreground=${colors.overlay2},"
              "foreground_text=${colors.text},"
              "background=${colors.base},"
              "background_text=${colors.text}"
            ];
          };
        })

        (mkIf (cfg.obs-studio.enable && config.programs.obs-studio.enable) {
          home.packages = [
            catppuccin-obs
          ];

          xdg.configFile."obs-studio/themes" = {
            source = "${catppuccin-obs}/themes";
            recursive = true;
          };
        })
      ]
    );
}
