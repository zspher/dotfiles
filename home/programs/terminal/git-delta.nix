{ pkgs, ... }:
{
  programs.delta = {
    enable = true;
    options.navigate = true;
    options.hunk-header-style = "omit";
    enableGitIntegration = true;
  };
  programs.lazygit.settings = {
    git.paging.pager = "delta --dark --paging=never";
  };
}
