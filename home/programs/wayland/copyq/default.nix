{ lib, ... }:
{
  services.copyq = {
    enable = true;
    forceXWayland = false;
  };

  xdg.configFile."copyq/copyq-commands.ini".source = ./commands.ini;

}
