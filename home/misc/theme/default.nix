{ config, ... }:
{
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";

  # the minimum needed for theming (i.e. in a tty: shell, cmdline)
  programs.bat.catppuccin.enable = true;
  programs.btop.catppuccin.enable = true;
  programs.fish.catppuccin.enable = true;
  programs.fzf.catppuccin.enable = true;
  programs.lazygit.catppuccin.enable = true;
  programs.starship.catppuccin.enable = true;
  programs.tmux.catppuccin.enable = true;

  home.sessionVariables = {
    GREP_COLORS = "ms=01;31";
  };

  programs.vivid = {
    enable = true;
    theme = "catppuccin-${config.catppuccin.flavor}";
  };

  theme.catppuccin = {
    git-delta.enable = true;
  };
}
