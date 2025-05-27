{ pkgs, ... }:
let
  polkit = pkgs.kdePackages.polkit-kde-agent-1;
in
{
  systemd.user.services.polkit-kde-agent-1 = {
    Unit = {
      Description = "polkit-kde-agent-1";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${polkit}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
