{pkgs, ...}: {
  imports = [
    ./kde-polkit-agent.nix
    ./gpg.nix
  ];
  home.packages = with pkgs; [
    keepassxc
  ];
}
