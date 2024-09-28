{ ... }:
{
  programs.fzf = {
    enable = true;
    changeDirWidgetCommand = "fd -L -td --hidden --exclude .git";
    fileWidgetCommand = "fd -L -td -tf --hidden --exclude .git";
  };
}
