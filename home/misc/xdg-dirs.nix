{ config, ... }:
{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
    GOPATH = "${config.xdg.dataHome}/go";
    OMNISHARPHOME = "${config.xdg.configHome}/omnisharp";
    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo\${TERMINFO_DIRS:+:$TERMINFO_DIRS}";
    VAGRANT_HOME = "${config.xdg.dataHome}/vagrant";
  };
}
