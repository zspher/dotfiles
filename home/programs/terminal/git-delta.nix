{
  pkgs,
  config,
  inputs,
  ...
}: {
  home.packages = [pkgs.delta];
  programs.git = {
    extraConfig = {
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      diff.colorMoved = true;

      delta.features = "catppuccin-${config.catppuccin.flavor}";
      delta.navigate = true;
      delta.hunk-header-style = "omit";
    };
    includes = [
      {
        path = "${inputs.catppuccin-delta}/catppuccin.gitconfig";
      }
    ];
  };
  programs.lazygit.settings = {
    git.paging.pager = "delta --dark --paging=never";
  };
  programs.bat = {
    enable = true;
  };
}
