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
    "svg+xml"
    "tiff"
    "webp"
  ];
  video = xdgAssociations "video" videoPlayer [
    "avi"
    "mkv"
    "mp4"
    "mov"
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

  documentTypes = {
    "image/vnd.djvu+multipage" = [ "org.pwmt.zathura" ];
    "application/pdf" = [ "org.pwmt.zathura" ];
    "application/epub+zip" = [ "org.pwmt.zathura" ];

    "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = [ "writer" ];
  };

  # XDG MIME types
  associations = builtins.mapAttrs (_: v: (map (e: "${e}.desktop") v)) (
    {
      "text/html" = browser;
      "text/plain" = [ "nvim" ];

      "inode/directory" = [ "org.kde.dolphin" ];
    }
    // image
    // video
    // audio
    // browserTypes
    // documentTypes
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
    terminal-exec.enable = true;
  };
}
