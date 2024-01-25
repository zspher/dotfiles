{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [cargo];
  home.sessionVariables.CARGO_HOME = "${config.xdg.dataHome}/cargo";
}
