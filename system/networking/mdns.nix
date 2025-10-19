{ ... }:
{
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  networking.networkmanager.connectionConfig."connection.mdns" = 2;
  networking.firewall.allowedUDPPorts = [
    5353
    5355
  ];
  networking.firewall.allowedTCPPorts = [
    5353
    5355
  ];
}
