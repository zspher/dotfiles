{pkgs, ...}: {
  imports = [
    ./brave.nix
  ];
  home.packages = with pkgs; [
    cloudflare-warp
    curl
    inetutils
    qbittorrent
    webcord
    wget
    yt-dlp
  ];
}
