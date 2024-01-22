{pkgs, ...}: {
  imports = [
    ./neovim
    ./gpg.nix
    ./git.nix
  ];
  home.packages = with pkgs; [
    btop
    kitty
    gcc

    lazygit
    ripgrep
    fd
  ];
}
