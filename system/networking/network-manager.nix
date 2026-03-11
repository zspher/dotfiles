{ ... }:
{
  networking.networkmanager.enable = true;
  networking.firewall.allowedUDPPorts = [
    #warframe
    4950
    4955
  ];
}
