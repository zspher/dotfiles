{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # vagrant # TODO: uncomment in next vagrant update; see: https://github.com/NixOS/nixpkgs/issues/348938
  ];
  # virtualisation.virtualbox.guest.enable = true;
  # virtualisation.virtualbox.host.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = with pkgs; [
    virtiofsd
  ];
  programs.virt-manager.enable = true;
}
