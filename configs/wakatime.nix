{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [wakatime];
  home.sessionVariables.WAKATIME_HOME = "${config.xdg.configHome}/wakatime";
  xdg.configFile."wakatime/.keep".text = "";
}
