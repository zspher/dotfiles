{
  pkgs,
  lib,
  config,
  ...
}:
let
  script = import ./swww-wallset.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    swww
  ];

  systemd.user.services.swww = {
    Unit = {
      Description = "swww wallpapers";
      PartOf = [ "graphical-session.target" ];
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "notify";
      NotifyAccess = "all";
      ExecStart = "${script}/bin/swww-wallset";
      ExecStop = "${lib.getExe pkgs.swww} kill";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
