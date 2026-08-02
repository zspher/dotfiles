{ ... }:
{
  programs.fzf =
    let
      skipDirs = "--walker-skip .git,node_modules,.cache,.direnv,.steam,.local";
    in
    {
      enable = true;
      changeDirWidget.options = [ skipDirs ];
      fileWidget.options = [ skipDirs ];
    };
  catppuccin.fzf.enable = true; # IFD
}
