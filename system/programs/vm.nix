{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    OVMF
  ];
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [
    virtiofsd
  ];
  programs.virt-manager.enable = true;
}
