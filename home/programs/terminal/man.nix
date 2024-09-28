{ ... }:
{
  programs.man.enable = true;
  programs.man.generateCaches = true;
  home.sessionVariables.MANROFFOPT = "-c";
}
