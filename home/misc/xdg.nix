{ ... }:
let
  browser = [ "brave-browser" ];
  imageViewer = [ "qimgv" ];
  videoPlayer = [ "mpv" ];
  audioPlayer = [ "mpv" ];

  xdgAssociations =
    type: program: list:
    builtins.listToAttrs (
      map (e: {
        name = "${type}/${e}";
        value = program;
      }) list
    );

  image = xdgAssociations "image" imageViewer [
    "avif"
    "gif"
    "heif"
    "jpeg"
    "jxl"
    "png"
    "svg"
    "tiff"
    "webp"
  ];
  video = xdgAssociations "video" videoPlayer [
    "avi"
    "mkv"
    "mp4"
  ];
  audio = xdgAssociations "audio" audioPlayer [
    "aac"
    "flac"
    "mp3"
    "wav"
  ];
  browserTypes =
    (xdgAssociations "application" browser [
      "x-extension-htm"
      "x-extension-html"
      "x-extension-shtml"
      "x-extension-xht"
      "x-extension-xhtml"
    ])
    // (xdgAssociations "x-scheme-handler" browser [
      "about"
      "ftp"
      "http"
      "https"
      "unknown"
    ]);

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) (
    {
      "image/vnd.djvu" = [ "org.kde.okular" ];
      "application/pdf" = [ "org.kde.okular" ];

      "text/html" = browser;
      "text/plain" = [ "nvim" ];

      "inode/directory" = [ "org.kde.dolphin" ];
    }
    // image
    // video
    // audio
    // browserTypes
  );
in
{
  xdg = {
    enable = true;
    userDirs.enable = true;
    userDirs.createDirectories = true;
    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };
  };
}
