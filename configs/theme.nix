{
  data,
  pkgs,
  lib,
  ...
}: let
  veryBigNum = 100000;
  upperFirst = str: (lib.strings.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 veryBigNum str);

  theme = {
    name = data.theme.name;
    variant = data.theme.variant;
    accent = data.theme.accent;
    type = "dark";
    package = pkgs.catppuccin.override {
      accent = data.theme.accent;
      variant = data.theme.variant;
    };
  };
in {
  home.packages = [theme.package];

  programs.kitty.theme = "${upperFirst theme.name}-${upperFirst theme.variant}";

  programs.btop.settings.color_theme = "${theme.name}_${theme.variant}";
  xdg.configFile."btop/themes" = {
    source = "${theme.package}/btop";
    recursive = true;
  };

  programs.starship.settings =
    {palette = "${theme.name}_${theme.variant}";}
    // builtins.fromTOML (
      builtins.readFile
      "${theme.package}/starship/${theme.variant}.toml"
    );
}
