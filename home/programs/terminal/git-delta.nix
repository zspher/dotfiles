{ pkgs, ... }:
{
  programs.delta = {
    enable = true;
    options.navigate = true;
    options.hunk-header-style = "omit";
    enableGitIntegration = true;
  };
  programs.lazygit.settings = {
    git.diffRenderers = [ { command = "delta --dark --paging=never"; } ];
  };
  catppuccin.delta.enable = true;
}
