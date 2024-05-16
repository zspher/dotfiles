{pkgs, ...}: {
  imports = [
    ./brave.nix
  ];
  home.packages = with pkgs; [
    inetutils
    qbittorrent
    webcord
    yt-dlp
  ];
}
