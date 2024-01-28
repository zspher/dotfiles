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
    };
    variant = mkOption {
      type = types.enum ["latte" "frappe" "macchiato" "mocha"];
      default = "mocha";
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
      default = "mauve";
      description = "Main accent to use for catppuccin";
    };

    kitty.enable =
      mkEnableOption "kitty integration"
      // {
        default = true;
      };

    btop.enable =
      mkEnableOption "btop integration"
      // {
        default = true;
      };

    starship.enable =
      mkEnableOption "starship integration"
      // {
        default = true;
      };

    kvantum.enable = mkEnableOption "kvantum integration";

    gtk = {
      enable = mkEnableOption "gtk integration";
      package = mkOption {
        type = types.package;
        default = pkgs.catppuccin-gtk;
        defaultText = literalExpression "pkgs.catppuccin-gtk";
        description = "The package to use for catppuccin gtk theme";
      };
      finalPackage = mkOption {
        type = types.package;
        readOnly = true;
        description = "The resulting catppuccin gtk theme package";
      };
    };
  };

  config = let
    kvantum-theme = "Catppuccin-${upperFirst cfg.variant}-${upperFirst cfg.accent}";
  in
    mkIf cfg.enable (
      mkMerge [
        {
          theme.catppuccin.finalPackage = cfg.package.override {
            accent = cfg.accent;
            variant = cfg.variant;
          };

          theme.catppuccin.type = (
            if builtins.elem cfg.variant ["frappe" "macchiato" "mocha"]
            then "dark"
            else "light"
          );

          home.packages = [cfg.finalPackage];

          programs.kitty.theme =
            mkIf cfg.kitty.enable (mkDefault "Catppuccin-${upperFirst cfg.variant}");

          programs.btop.settings.color_theme =
            mkIf cfg.btop.enable (mkDefault "catppuccin_${cfg.variant}");
          xdg.configFile."btop/themes" = mkIf cfg.btop.enable {
            source = "${cfg.finalPackage}/btop";
            recursive = true;
          };

          programs.starship.settings =
            mkIf cfg.starship.enable
            (mkDefault (
              {palette = "catppuccin_${cfg.variant}";}
              // builtins.fromTOML (
                builtins.readFile
                "${cfg.finalPackage}/starship/${cfg.variant}.toml"
              )
            ));
        }

        (mkIf cfg.kvantum.enable {
          qt = {
            style.name = "kvantum";
          };
          xdg.configFile."Kvantum/kvantum.kvconfig".text = generators.toINI {} {
            General.theme = "${kvantum-theme}#";
          };
          xdg.configFile."Kvantum/${kvantum-theme}#/${kvantum-theme}#.kvconfig".source = pkgs.substitute {
            src = "${cfg.finalPackage}/share/Kvantum/${kvantum-theme}/${kvantum-theme}.kvconfig";
            replacements = ["--replace" "translucent_windows=false" "translucent_windows=true"];
          };
        })

        (mkIf cfg.gtk.enable {
          theme.catppuccin.gtk.finalPackage = cfg.gtk.package.override {
            accents = [cfg.accent];
            variant = cfg.variant;
          };
          gtk = {
            theme.name = lib.concatStrings [
              "Catppuccin-"
              "${upperFirst cfg.variant}-"
              "Standard-"
              "${upperFirst cfg.accent}-"
              "${upperFirst cfg.type}"
            ];
            theme.package = cfg.gtk.finalPackage;
          };
        })
      ]
    );
}
