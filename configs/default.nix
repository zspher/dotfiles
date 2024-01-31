{pkgs, ...}: {
  imports = [
    ./neovim
    ./gpg.nix
    ./git.nix
    ./anyrun.nix
    ./zsh
    ./starship.nix
    ./dolphin.nix
    ./kitty
    ./wakatime.nix
    ./cargo.nix
    ./fzf.nix
    ./btop.nix
    ./lazygit.nix

    ./look-and-feel.nix
  ];
  home.packages = with pkgs; [
    # internet
    brave # TODO: cfg
    inetutils
    rclone # TODO: cfg
    webcord
    yt-dlp

    # multimedia
    grimblast
    hyprpicker
    timg
    qimgv

    # utilities
    ark
    filelight
    font-manager
    (nwg-displays.override {hyprlandSupport = true;})
    pavucontrol

    # utilities: terminal
    bat
    brightnessctl
    fd
    jq
    lsd
    playerctl
    ripgrep
    rsync
    wl-clipboard-rs
    xdotool

    # utilities: diagnostics
    nvtop
    s-tui
    wev

    # security
    keepassxc
    # polkit-kde-agent
  ];
  services.blueman-applet.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  services.copyq.enable = true; # TODO: cfg
}
