{...}: {
  programs.less = {
    enable = true;
  };
  home.sessionVariables.LESS = "-R --use-color -Dd+r\\$Du+b\\$";
}
