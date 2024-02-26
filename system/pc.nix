{
  pkgs,
  inputs,
  data,
  ...
}: let
  inherit (data) username keys;
in {
  imports = [
    ./sddm
  ];
  # kernel
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    initrd.availableKernelModules = [
      "xhci_pci"
      "ehci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    kernelModules = ["kvm-intel"];
  };

  # hardware
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = ["subvol=root" "compress=zstd"];
    };
    "/home" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = ["subvol=home" "compress=zstd"];
    };
    "/nix" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
      options = ["subvol=nix" "compress=zstd" "noatime"];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/2ED7-2A30";
      fsType = "vfat";
    };
    "/mnt/drive2" = {
      device = "/dev/disk/by-label/drive2";
      fsType = "ext4";
    };
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/f2cb2ead-1cb7-46f3-b7b0-e4e84fa49025";}
  ];
  zramSwap.enable = true;

  hardware.cpu.intel.updateMicrocode = true;

  nixpkgs.hostPlatform = "x86_64-linux";

  # networking & services
  networking.hostName = "c-100";
  networking.networkmanager.dns = "dnsmasq";
  networking.nameservers = ["1.1.1.1"];

  # TODO: pls remove when services.warp-svc becomes available
  systemd.packages = [pkgs.cloudflare-warp];
  systemd.targets.multi-user.wants = ["warp-svc.service"];

  users.users.syncthing.homeMode = "750";
  systemd.services.syncthing.serviceConfig.UMask = "0007";
  services.syncthing = {
    enable = true;
    overrideDevices = false;
    overrideFolders = false;
    openDefaultPorts = true;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.udisks2.enable = true;
  services.fstrim.enable = true;

  security.pam.services.swaylock = {};

  # programs
  programs.kdeconnect.enable = true;
  programs.hyprland.enable = true;
  programs.zsh.enable = true;
  programs.dconf.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # services
  services.blueman.enable = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  services.openssh.enable = true;
  services.openssh.settings.PasswordAuthentication = false;

  # fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaMono" "Noto"];})
  ];
  environment.systemPackages = with pkgs; [
    gcc
    clang
    gparted
  ];

  # user
  users.users = {
    "${username}" = {
      shell = pkgs.zsh;
      initialPassword = "defaultPass";
      isNormalUser = true;
      openssh.authorizedKeys = {inherit keys;};

      extraGroups = ["wheel" "networkmanager" "syncthing"];
    };
  };
}
