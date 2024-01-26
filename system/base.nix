{
  pkgs,
  data,
  ...
}: let
  inherit (data) username keys;
in {
  networking.networkmanager.enable = true;
  networking.networkmanager.dns = "dnsmasq";
  networking.nameservers = ["1.1.1.1"];
  users.users = {
    root.hashedPassword = "!";
    "${username}" = {
      shell = pkgs.zsh;
      initialPassword = "defaultPass";
      isNormalUser = true;
      openssh.authorizedKeys = {inherit keys;};

      extraGroups = ["wheel" "networkmanager"];
    };
  };

  # nix/nixos
  hardware.enableRedistributableFirmware = true;
  nixpkgs = {
    overlays = [];
    config.allowUnfree = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };
  nix.settings = {
    experimental-features = "nix-command flakes";
    auto-optimise-store = true;
  };

  # programs
  programs.zsh.enable = true;
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    home-manager

    gcc
    clang
    gparted

    cloudflare-warp
  ];

  # TODO: pls remove when services.warp-svc becomes available
  systemd.packages = [pkgs.cloudflare-warp];
  systemd.targets.multi-user.wants = ["warp-svc.service"];

  # services
  services = {
    openssh.enable = true;
    openssh.settings.PermitRootLogin = "no";
    avahi = {
      ipv6 = true;
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      publish.enable = true;
      publish.userServices = true;
      publish.domain = true;
    };
    syncthing = {
      enable = true;
      overrideDevices = false;
      overrideFolders = false;
      openDefaultPorts = true;
    };
  };

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
