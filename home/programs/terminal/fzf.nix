{...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
    changeDirWidgetCommand = "fd -L -td --hidden --exclude .git";
    fileWidgetCommand = "fd -L -td -tf --hidden --exclude .git";
  };
}
