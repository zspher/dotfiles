{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.services.copyq;
in {
  config = lib.mkIf cfg.enable {
    assertions = [
      (lib.hm.assertions.assertPlatform "services.copyq" pkgs
        lib.platforms.linux)
    ];
    systemd.user.services.copyq = {
      Service = {
        ExecStart = lib.mkForce "${cfg.package}/bin/copyq --start-server";
      };
    };
  };
}
