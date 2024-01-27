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
    kittyIntegration =
      mkEnableOption "kitty integration"
      // {
        default = true;
      };
    btopIntegration =
      mkEnableOption "btop integration"
      // {
        default = true;
      };
    starshipIntegration =
      mkEnableOption "starship integration"
      // {
        default = true;
      };
  };

  config = mkIf cfg.enable {
    theme.catppuccin.finalPackage = cfg.package.override {
      accent = cfg.accent;
      variant = cfg.variant;
    };
    home.packages = [cfg.finalPackage];

    programs.kitty.theme = mkIf cfg.kittyIntegration "Catppuccin-${upperFirst cfg.variant}";

    programs.btop.settings.color_theme = mkIf cfg.btopIntegration "catppuccin_${cfg.variant}";
    xdg.configFile."btop/themes" = mkIf cfg.btopIntegration {
      source = "${cfg.finalPackage}/btop";
      recursive = true;
    };

    programs.starship.settings =
      mkIf cfg.starshipIntegration
      ({palette = "catppuccin_${cfg.variant}";}
        // builtins.fromTOML (
          builtins.readFile
          "${cfg.finalPackage}/starship/${cfg.variant}.toml"
        ));
  };
}
