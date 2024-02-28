{pkgs, ...}: {
  imports = [
    ./btop.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./less.nix
    ./man.nix
    ./neovim
    ./starship.nix
    ./tealdeer.nix
    ./zsh
  ];
  home.packages = with pkgs; [
    brightnessctl
    fd
    ghostscript
    (inxi.override {withRecommendedSystemPrograms = true;})
    jq
    lsd
    nvtop
    playerctl
    ripgrep
    rsync
    wev
    xdg-utils
  ];
}
