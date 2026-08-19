{ pkgs, ... }:
{
  # printers
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
    hplip
  ];

  hardware.printers.ensurePrinters = [
    # {
    #   name = "HP-6962";
    #   deviceUri = "ipps://hpf68113";
    #   model = "everywhere";
    # }
  ];

  # scanners
  hardware.sane = {
    enable = true;
  };
}
