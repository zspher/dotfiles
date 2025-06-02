{ pkgs, ... }:
{
  imports = [
    # ./kde-polkit-agent.nix
    ./keepassxc.nix
    # ./gnome-keyring.nix
    ./gpg.nix
  ];

  services.polkit-gnome.enable = true;
}
