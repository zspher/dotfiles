{ ... }:
{
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = true;
  networking.firewall.allowedUDPPorts = [
    #warframe
    4950
    4955
  ];
}
