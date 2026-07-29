{ pkgs, config, ... }:
let
  vicinaeExtensions =
    pkgs.fetchFromGitHub {
      owner = "vicinaehq";
      repo = "extensions";
      rev = "3ac7d25baa16ad5f1a6227c3e4b4b21a7c3e452b";
      sha256 = "sha256-7kyqXXQyRVy41vWled33nJZFbtrGaBJlO4+uSE0Ct18=";
    }
    + "/extensions";

in
{
  programs.vicinae = {
    enable = true;
    systemd.enable = true;
    extensions = [
      (config.lib.vicinae.mkExtension {
        name = "color-converter";
        npmDepsHash = "sha256-EYvMY+NoCm8NaU3pEV5QUYEUkYZZiYXx7eCDD20TzrM=";
        src = vicinaeExtensions + "/color-converter";
      })
      (config.lib.vicinae.mkExtension {
        name = "nix";
        npmDepsHash = "sha256-TEyCCDjAtRYX2uH2TpLfe4/hTzyfMiyDhzVdyQXhEus=";
        src = vicinaeExtensions + "/nix";
      })
      (config.lib.vicinae.mkExtension {
        name = "screenshot";
        npmDepsHash = "sha256-6Ou1bkdCpg89iCBZRGVUQH/mBIxdRvlQH8HM+TXbyZo=";
        src =
          pkgs.fetchFromGitHub {
            owner = "zspher";
            repo = "vicinae_extensions";
            rev = "748ce4a2174f51c224c30a521d60b0834020d8f8";
            hash = "sha256-tNGpEqEQ20cfdg8plQtw5FR4QEMRFWXsHZY1J/B82oA=";
          }
          + "/screenshot";
      })
      # TODO: add websearch extension
    ];
    settings = {
      fallbacks = [ ];
      telemetry.system_info = false;
      input_server.enabled = false;
      providers = {
        "browser-extension".enabled = false;
        files.enabled = false;
        files.preferences.autoIndexing = false;
        snippets.enabled = false;
        clipboard.entrypoints.history.preferences.defaultAction = "copy";
        power.entrypoints.logout.preferences.customProgram = "uwsm stop";
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$runner" = "vicinae toggle";
    "$clipboard_manager" = "vicinae 'vicinae://launch/clipboard/history'";
    "$power_menu" = "vicinae 'vicinae://launch/power'";
    "$screenshot" = "vicinae 'vicinae://launch/@zspher/screenshot/screenshot'";
  };
}
