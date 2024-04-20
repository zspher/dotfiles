{pkgs, ...}: {
  home.packages = with pkgs; [davinci-resolve];
  xdg.desktopEntries.davinci-resolve = {
    name = "Davinci Resolve";
    genericName = "DaVinci Resolve";
    exec = "env __NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia QT_QPA_PLATFORM=xcb davinci-resolve %u";
    type = "Application";
    terminal = false;
    icon = "camera-video";
    startupNotify = true;
    settings.StartupWMClass = "resolve";
    mimeType = ["application/x-resolveproj"];
  };
}
