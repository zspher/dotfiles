{ pkgs, ... }:
{
  # printers
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    epson-201401w
    gutenprint
  ];

  hardware.printers.ensurePrinters = [
    {
      name = "EPSON-L220";
      deviceUri = "usb://EPSON/L220%20Series?serial=5647574B3131353901";
      model = "gutenprint.5.3://escp2-l210/expert";
    }
  ];

  # scanners
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.utsushi ];
  };
  services.udev.packages = [ pkgs.utsushi ];
}
