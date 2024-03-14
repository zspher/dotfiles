{...}: let
  inherit (import ../config.nix) user;
in {
  systemd.services.syncthing.serviceConfig.UMask = "0007";
  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
  };
}
