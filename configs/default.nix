{pkgs, ...}: {
  imports = [
    # utilities
    ./anyrun.nix
    ./dolphin.nix
    ./gpg.nix
    ./kitty
    ./wakatime.nix

    # utilities: terminal
    ./btop.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./neovim
    ./starship.nix
    ./zsh

    # dev
    ./cargo.nix

    # internet
    ./brave.nix

    ./look-and-feel.nix
  ];
  home.packages = with pkgs; [
    # internet
    inetutils
    # rclone # cfg
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
