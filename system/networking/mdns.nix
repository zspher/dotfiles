{...}: {
  services.avahi.enable = true;
  services.resolved.enable = true;
  networking.networkmanager.connectionConfig."connection.mdns" = 2;
}
