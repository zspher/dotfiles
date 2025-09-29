{ lib, ... }:
{
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };

  xdg.configFile."copyq/copyq-commands.ini".source = ./commands.ini;
  qt.kde.settings."copyq/copyq.conf" = {
    close_on_unfocus = false;
    maxitems = 50;
  };
}
