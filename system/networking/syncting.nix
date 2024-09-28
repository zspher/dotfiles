{ ... }:
let
  inherit (import ../config.nix) username;
in
{
  systemd.services.syncthing.serviceConfig.UMask = "0007";
  services.syncthing = {
    enable = true;
    user = username;
    dataDir = "/home/${username}/Documents";
    configDir = "/home/${username}/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
  };
}
