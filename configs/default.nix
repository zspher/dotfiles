{pkgs, ...}: {
  imports = [
    # utilities
    ./anyrun.nix
    ./dolphin.nix
    ./gpg.nix
    ./kitty
    ./swaync.nix
    ./wakatime.nix
    ./waybar.nix

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

    # multimedia
    ./mpv.nix
    ./spicetify.nix

    # security
    ./kde-polkit-agent.nix

    ./look-and-feel.nix
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
  ];
  services.blueman-applet.enable = true;
  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
  services.copyq.enable = true; # TODO: cfg
}
