{ pkgs, ... }:
{
  home.packages = with pkgs; [ polkit-kde-agent ];
  systemd.user.services.polkit-kde-agent = {
    Unit = {
      Description = "polkit-kde-agent";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };
    Service = {
      ExecStart = "${pkgs.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1";
      Restart = "always";
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
}
