{pkgs, ...}: {
  imports = [
    ./neovim
    ./gpg.nix
    ./git.nix
    ./anyrun
    ./zsh
    ./starship.nix
    ./kitty
    ./wakatime.nix
    ./cargo.nix
    ./fzf.nix
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
    dolphin
    filelight
    font-manager
    (nwg-displays.override {hyprlandSupport = true;})
    pavucontrol

    # utilities: terminal
    bat
    brightnessctl
    fd
    jq
    lazygit
    lsd
    playerctl
    ripgrep
    rsync
    xdotool

    # utilities: diagnostics
    btop # TODO: cfg
    nvtop
    s-tui
    wev

    # security
    keepassxc
    # polkit-kde-agent

    # kimageformats
    # ffmpegthumbs
    # kdegraphics-thumbnailers
    # libheif
    # resvg
    # kde-cli-tools
    # ffmpegthumbnailer
    # udiskie
  ];
  services.blueman-applet.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
