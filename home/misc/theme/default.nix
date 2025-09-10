{ config, ... }:
{
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";

  # the minimum needed for theming (i.e. in a tty: shell, cmdline)
  catppuccin.bat.enable = true;
  catppuccin.btop.enable = true;
  catppuccin.delta.enable = true;
  catppuccin.fish.enable = true;
  catppuccin.fzf.enable = true;
  catppuccin.lazygit.enable = true;
  catppuccin.starship.enable = true;
  catppuccin.tmux.enable = true;

  home.sessionVariables = {
    GREP_COLORS = "ms=01;31";
  };

  programs.vivid = {
    enable = true;
    activeTheme = "catppuccin-${config.catppuccin.flavor}";
  };
}
