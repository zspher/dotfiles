{ config, ... }:
{
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";
  catppuccin.enable = true;
  catppuccin.autoEnable = false;

  home.sessionVariables = {
    GREP_COLORS = "ms=01;31";
  };

  programs.vivid = {
    enable = true;
    activeTheme = "catppuccin-${config.catppuccin.flavor}";
  };
}
