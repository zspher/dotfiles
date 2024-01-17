{pkgs, ...}: {
  imports = [
    ./neovim
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
