{pkgs, ...}: let
  inherit (import ./config.nix) user;
in {
  users.users.${user} = {
    shell = pkgs.zsh;
    initialPassword = "defaultPass";
    isNormalUser = true;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILgO9M53gSwDCnfPMUNctkcLmqwVtvnzskbjyGVspNp5 zspher@ls-2000"
    ];

    extraGroups = ["wheel" "networkmanager" "syncthing" "vboxusers"];
  };
}
