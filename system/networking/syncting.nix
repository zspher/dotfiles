{...}: let
  inherit (import ../config.nix) user;
in {
  systemd.services.syncthing.serviceConfig.UMask = "0007";
  services.syncthing = {
    enable = true;
    inherit user;
    dataDir = "/home/${user}/Documents";
    configDir = "/home/${user}/.config/syncthing";
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
  };
}
