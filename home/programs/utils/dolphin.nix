{pkgs, ...}: {
  home.packages = with pkgs; [
    libsForQt5.dolphin
    libsForQt5.kio-extras # thumbnail service
    # https://invent.kde.org/frameworks/kimageformats
    libsForQt5.kimageformats # avif, xcf, jxl
    # https://apps.kde.org/kdegraphics_thumbnailers/
    libsForQt5.kdegraphics-thumbnailers # PS, PDF, RAW, mobi, blender
    libsForQt5.ffmpegthumbs # video thumbnails
  ];
}
