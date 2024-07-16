{pkgs, ...}: {
  imports = [
    ./bash.nix
    ./btop.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./less.nix
    ./man.nix
    ./neovim
    ./starship.nix
    ./tealdeer.nix
    ./tmux.nix
    # ./zsh
  ];
  home.packages = with pkgs; [
    fd
    ghostscript
    (inxi.override {withRecommendedSystemPrograms = true;})
    jq
    lsd
    ripgrep
    rsync
    xdg-utils
  ];
}
