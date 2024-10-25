{ pkgs, ... }:
{
  systemd.packages = [ pkgs.cloudflare-warp ];
  systemd.targets.multi-user.wants = [ "warp-svc.service" ];
}
