{ pkgs, ... }:
{
  services.udisks2.enable = true;
  services.udev.packages = [ pkgs.libmtp.out ];
  services.usbmuxd = {
    package = pkgs.usbmuxd2;
    enable = true;
  };
}
