{
  pkgs,
  data,
  ...
}: let
  inherit (data) username keys;
in {
  networking.networkmanager.enable = true;
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
    use-xdg-base-directories = true;
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
  ];

  # services
  services = {
    openssh.enable = true;
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
