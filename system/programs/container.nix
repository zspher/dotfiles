{ pkgs, ... }:
{
  virtualisation.containers.enable = true;
  virtualisation.podman = {
    enable = true;
    defaultNetwork.settings.dns_enabled = true;
  };
  environment.systemPackages = with pkgs; [
    podman-tui
    podman-compose
  ];
}
