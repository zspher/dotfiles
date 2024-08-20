{pkgs, ...}: {
  home.packages = with pkgs.kdePackages; [
    dolphin
    kio-extras # thumbnail service, MTP, ACF
    # https://invent.kde.org/frameworks/kimageformats
    kimageformats # avif, xcf, jxl
    # https://apps.kde.org/kdegraphics_thumbnailers/
    kdegraphics-thumbnailers # PS, PDF, RAW, mobi, blender
    ffmpegthumbs # video thumbnails
    qtimageformats # for webp thumbnails
  ];
}
