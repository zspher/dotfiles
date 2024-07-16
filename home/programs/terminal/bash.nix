{
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    historyFile = "${config.xdg.stateHome}/bash/history";
    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${config.programs.fish.package}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
