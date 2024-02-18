{pkgs, ...}: {
  imports = [
    # utilities
    ./anyrun.nix
    ./copyq.nix
    ./dolphin.nix
    ./easyeffects.nix
    ./gpg.nix
    ./kitty
    ./rofi
    ./swayidle.nix
    ./swaync.nix
    ./swww
    ./wakatime.nix
    ./waybar.nix

    # utilities: terminal
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

    # internet
    ./brave.nix

    # multimedia
    ./mpv.nix
    ./obs-studio.nix
    ./spicetify.nix

    # security
    ./kde-polkit-agent.nix
    ./swaylock.nix

    ./look-and-feel.nix
    ./xdg-standard.nix
  ];
  home.packages = with pkgs; [
    # documents
    calibre
    libreoffice-fresh
    masterpdfeditor4
    obsidian
    okular
    #skanpage
    vscode-fhs

    # internet
    cloudflare-warp
    inetutils
    # rclone # cfg
    qbittorrent
    webcord
    yt-dlp

    # multimedia
    gimp
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
    brightnessctl
    fd
    (inxi.override {withRecommendedSystemPrograms = true;})
    jq
    lsd
    playerctl
    ripgrep
    rsync
    xdg-utils

    # utilities: diagnostics
    nvtop
    wev

    # security
    keepassxc
  ];
  services.blueman-applet.enable = true;
  services.network-manager-applet.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
