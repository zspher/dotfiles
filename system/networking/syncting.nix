{...}: {
  users.users.syncthing.homeMode = "750";
  systemd.services.syncthing.serviceConfig.UMask = "0007";
  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
  };
}
