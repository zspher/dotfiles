{
  pkgs,
  lib,
  config,
  ...
}:
let
  script = import ./awww-wallset.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    awww
  ];

  systemd.user.services.awww = {
    Unit = {
      Description = "awww wallpapers";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = "${script}/bin/awww-wallset";
      ExecStop = "${lib.getExe pkgs.awww} kill";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
