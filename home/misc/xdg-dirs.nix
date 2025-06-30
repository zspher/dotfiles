{ config, ... }:
{
  home.sessionVariables = {
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
    GOPATH = "${config.xdg.dataHome}/go";
    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    OMNISHARPHOME = "${config.xdg.configHome}/omnisharp";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo\${TERMINFO_DIRS:+:$TERMINFO_DIRS}";
    VAGRANT_HOME = "${config.xdg.dataHome}/vagrant";
  };
}
