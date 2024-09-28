{ pkgs, ... }:
{
  home.packages = [ pkgs.delta ];
  programs.git.extraConfig = {
    core.pager = "delta";
    interactive.diffFilter = "delta --color-only";
    diff.colorMoved = true;

    delta.navigate = true;
    delta.hunk-header-style = "omit";
  };
  programs.lazygit.settings = {
    git.paging.pager = "delta --dark --paging=never";
  };
}
