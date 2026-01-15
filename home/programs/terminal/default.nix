{ pkgs, ... }:
{
  imports = [
    ./bash.nix
    ./btop.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./gh.nix
    ./git-delta.nix
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
    hurl
    (inxi.override { withRecommends = true; })
    jq
    lsd
    ripgrep
    rsync
    xdg-utils
  ];
}
