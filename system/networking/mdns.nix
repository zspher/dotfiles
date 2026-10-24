{ ... }:
{
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    settings.publish.disable-publishing = false;
    settings.publish.publish-domain = true;
    settings.publish.publish-addresses = true;
  };
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
