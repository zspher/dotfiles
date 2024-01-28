{
  pkgs,
  data,
  ...
}: let
  inherit (data) username keys;
in {
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = ["xhci_pci" "usbhid" "usb_storage"];
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  nixpkgs.hostPlatform = "aarch64-linux";
  networking.hostName = "ns-200";

  users.users = {
    "${username}" = {
      shell = pkgs.zsh;
      initialPassword = "defaultPass";
      isNormalUser = true;
      openssh.authorizedKeys = {inherit keys;};

      extraGroups = ["wheel" "networkmanager"];
    };
  };
}
