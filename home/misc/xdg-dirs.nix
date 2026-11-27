{ config, lib, ... }:
let
  DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
in
{
  xdg.userDirs.setSessionVariables = true;
  home.sessionVariables = {
    AZURE_CONFIG_DIR = "${config.xdg.dataHome}/azure";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
    CUDA_CACHE_PATH = "${config.xdg.cacheHome}/nv";
    inherit DOTNET_CLI_HOME;
    GOPATH = "${config.xdg.dataHome}/go";
    GRADLE_USER_HOME = "${config.xdg.dataHome}/gradle";
    NPM_CONFIG_CACHE = "${config.xdg.cacheHome}/npm";
    NPM_CONFIG_INIT_MODULE = "${config.xdg.configHome}/npm/config/npm-init.js";
    NPM_CONFIG_TMP = "$XDG_RUNTIME_DIR/npm";
    NUGET_PACKAGES = "${config.xdg.cacheHome}/NuGetPackages";
    OMNISHARPHOME = "${config.xdg.configHome}/omnisharp";
    RUSTUP_HOME = "${config.xdg.dataHome}/rustup";
    TERMINFO = "${config.xdg.dataHome}/terminfo";
    TERMINFO_DIRS = "${config.xdg.dataHome}/terminfo\${TERMINFO_DIRS:+:$TERMINFO_DIRS}";
    VAGRANT_HOME = "${config.xdg.dataHome}/vagrant";
  };

  home.activation.genXDGdirs =
    let
      mkDir =
        x:
        let
          escaped = lib.escapeShellArg x;
        in
        ''
          [[ ! -e ${escaped} ]] && run mkdir -p ${escaped}
        '';
      dirs = [
        DOTNET_CLI_HOME
        "${config.xdg.configHome}/mozilla"
        "${config.xdg.configHome}/ipython"
        "${config.xdg.configHome}/pulse"
      ];
    in
    lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      ${lib.concatMapStrings mkDir dirs}
    '';
}
