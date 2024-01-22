{pkgs, ...}: {
  imports = [
    ./neovim
    ./gpg.nix
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
