{ pkgs, ... }:
let
  polkit = pkgs.kdePackages.polkit-kde-agent-1;
in
{
  home.packages = with pkgs; [ polkit ];
  systemd.user.services.polkit-kde-agent = {
    Unit = {
      Description = "polkit-kde-agent";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${polkit}/libexec/polkit-kde-authentication-agent-1";
      Restart = "always";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
