{pkgs, ...}: let
  nwg-displays = pkgs.nwg-displays.override {hyprlandSupport = true;};
in {
  imports = [
    ./neovim
    ./gpg.nix
    ./git.nix
    ./anyrun
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
    bat
    blueman
    brightnessctl
    dolphin
    fd
    filelight
    font-manager
    jq
    kitty #  TODO: cfg
    lazygit
    nwg-displays
    pavucontrol
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
