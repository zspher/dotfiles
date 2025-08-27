{ ... }:
{
  programs.fzf =
    let
      skipDirs = "--walker-skip .git,node_modules,.cache,.direnv,.steam,.local";
    in
    {
      enable = true;
      changeDirWidgetOptions = [ skipDirs ];
      fileWidgetOptions = [ skipDirs ];
    };
}
