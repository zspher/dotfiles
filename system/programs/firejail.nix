{
  lib,
  pkgs,
  config,
  ...
}:
{
  programs.firejail =
    let
      hostName = config.networking.hostName;
    in
    {
      enable = true;
      wrappedBinaries = {
        # FIX: no vesktop vc on tailscale up
        #      from: https://github.com/tailscale/tailscale/issues/10396#issuecomment-3871203280
        vesktop = {
          executable = "${lib.getBin pkgs.vesktop}/bin/vesktop";
          desktop = "${pkgs.vesktop}/share/applications/vesktop.desktop";
          profile = null;
          extraArgs = [
            "--noprofile"
          ]
          ++ lib.optional (hostName == "ls2100") "--net=wlo1"
          ++ lib.optional (hostName == "c100") "--net=wlp4s0";
        };
      };
    };
}
