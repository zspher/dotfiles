{ pkgs, ... }:
{
  programs.git.delta = {
    enable = true;
    options.navigate = true;
    options.hunk-header-style = "omit";
  };
  programs.lazygit.settings = {
    git.paging.pager = "delta --dark --paging=never";
  };
}
