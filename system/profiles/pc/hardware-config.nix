{
  lib,
  config,
  pkgs,
  ...
}:
{
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
      "usb_storage"
      "usbhid"
      "xhci_pci"
    ];
    kernelModules = [ "kvm-intel" ];
    blacklistedKernelModules = [
      "iTCO_wdt"
    ];

    kernelParams = [
      "intel_iommu=on"
      "nmi_watchdog=0"
    ];
  };

  # hardware
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/97943bb1-2816-47e7-9d5e-fcffb744cc68";
    fsType = "btrfs";
    options = [
      "subvol=root"
      "compress=zstd"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/97943bb1-2816-47e7-9d5e-fcffb744cc68";
    fsType = "btrfs";
    options = [
      "subvol=home"
      "compress=zstd"
    ];
  };
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/97943bb1-2816-47e7-9d5e-fcffb744cc68";
    fsType = "btrfs";
    options = [
      "subvol=nix"
      "compress=zstd"
      "noatime"
    ];
  };

  fileSystems."/mnt/d1" = {
    device = "/dev/disk/by-uuid/28cea1cd-4796-4299-aace-66c39b29ebb0";
    fsType = "btrfs";
    options = [
      "compress=zstd"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/CC67-63AE";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/412ee7db-6713-4016-807c-5c4cfee222c6"; }
  ];
  zramSwap.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      libva-vdpau-driver # required by davinci resolve

      intel-media-driver # vaapi
      vpl-gpu-rt # vpl api
      intel-compute-runtime # opencl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      intel-media-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    powerManagement.enable = true;
  };

  services.fstrim.enable = true; # for ssd
  services.thermald.enable = true;

  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
