{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../hardware
    ../../hardware/bluetooth.nix
    ../../hardware/printer-scanner.nix
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
    options = ["umask=0077"];
  };

  fileSystems."/mnt/drive2" = {
    device = "/dev/disk/by-label/drive2";
    fsType = "btrfs";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/8a283110-c511-43c7-96b4-e45b0bfce74f";}
  ];

  zramSwap.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau # required by davinci resolve
    ];
  };

  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    open = true;
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
