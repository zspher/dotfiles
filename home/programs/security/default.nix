{ pkgs, ... }:
{
  imports = [
    # ./kde-polkit-agent.nix
    ./keepassxc.nix
    ./gpg.nix
  ];

  services.polkit-gnome.enable = true;
}
