{...}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = false;
    changeDirWidgetCommand = "fd -L -td --hidden --exclude .git";
    fileWidgetCommand = "fd -L -td -tf --hidden --exclude .git";
    colors = {
      "bg+" = "#313244";
      "bg" = "#1e1e2e";
      "fg" = "#cdd6f4";
      "fg+" = "#cdd6f4";
      "hl" = "#f38ba8";
      "hl+" = "#f38ba8";
      "spinner" = "#f5e0dc";
      "header" = "#f38ba8";
      "info" = "#cba6f7";
      "pointer" = "#f5e0dc";
      "marker" = "#f5e0dc";
      "prompt" = "#cba6f7";
    };
  };
}
