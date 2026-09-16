{ pkgs, ... }:
{
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemu.vhostUserPackages = with pkgs; [
      virtiofsd
    ];
  };
  programs.virt-manager.enable = true;
  networking.firewall.interfaces."virbr*".allowedUDPPorts = [
    53 # DNS
    67 # DHCPv4
    547 # DHCPv6
  ];
  networking.firewall.interfaces."virbr*".allowedTCPPorts = [
    53 # DNS

    1433 # Sql server
  ];
}
