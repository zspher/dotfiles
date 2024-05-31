{pkgs, ...}: {
  virtualisation.virtualbox.host.enable = true;
  environment.systemPackages = with pkgs; [
    vagrant
  ];
  virtualisation.virtualbox.guest.enable = true;
}
