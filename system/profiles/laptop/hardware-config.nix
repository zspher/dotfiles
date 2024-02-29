{
  lib,
  config,
  ...
}: {
  imports = [
    ../../hardware
    ../../hardware/bluetooth.nix
  ];
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.availableKernelModules = [
      "ahci"
      "nvme"
      "sd_mod"
      "sdhci_pci"
      "usb_storage"
      "usbhid"
      "vmd"
      "xhci_pci"
    ];
    kernelModules = ["kvm-intel"];
    kernelParams = ["intel_pstate=disable"];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/76633a56-4e98-4e1f-bf64-b90f71dc3463";
    fsType = "btrfs";
    options = ["subvol=root" "compress=zstd"];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/76633a56-4e98-4e1f-bf64-b90f71dc3463";
    fsType = "btrfs";
    options = ["subvol=home" "compress=zstd"];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/76633a56-4e98-4e1f-bf64-b90f71dc3463";
    fsType = "btrfs";
    options = ["subvol=nix" "compress=zstd" "noatime"];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/442E-476E";
    fsType = "vfat";
  };

  swapDevices = [];

  zramSwap.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.finegrained = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  services.fstrim.enable = true; # for ssd

  services.thermald.enable = true;
}
