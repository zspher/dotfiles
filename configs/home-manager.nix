{
  config,
  data,
  ...
}: let
  inherit (data) username;
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      XDG_DATA_HOME = "${config.xdg.dataHome}";
      XDG_CONFIG_HOME = "${config.xdg.configHome}";
      XDG_STATE_HOME = "${config.xdg.stateHome}";
      XDG_CACHE_HOME = "${config.xdg.cacheHome}";
    };
  };
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;
}
