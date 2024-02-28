{pkgs, ...}: {
  programs.mpv = {
    enable = true;
    config = {
      osd-bar = false;
      border = false;
      sub-font-size = 32;
      sub-margin-y = 40;
      ytdl-format = "best[height<=480]";
    };
    scripts = with pkgs; [
      mpvScripts.uosc
      mpvScripts.mpris
      mpvScripts.thumbfast
      mpvScripts.sponsorblock
    ];
  };
}
