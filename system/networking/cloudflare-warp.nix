{pkgs, ...}: {
  # TODO: pls remove when services.warp-svc becomes available
  systemd.packages = [pkgs.cloudflare-warp];
  systemd.targets.multi-user.wants = ["warp-svc.service"];
}
