{config, ...}: {
  home.sessionVariables = {
    DOTNET_CLI_HOME = "${config.xdg.dataHome}/dotnet";
    OMNISHARPHOME = "${config.xdg.configHome}/omnisharp";
    CARGO_HOME = "${config.xdg.dataHome}/cargo";
  };
}
