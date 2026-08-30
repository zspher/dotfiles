{ pkgs, config, ... }:
let
  vicinaeExtensions =
    pkgs.fetchFromGitHub {
      owner = "vicinaehq";
      repo = "extensions";
      rev = "de926d2e94ff4423dc04068eb2b6fc8d501f3b74";
      sha256 = "sha256-YVr/SysyzG2lkSpacrEC/Mo7XdUYdKu5vX2AUcqAzpQ=";
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
      # (config.lib.vicinae.mkExtension { # does not work
      #   name = "dbus";
      #   npmDepsHash = "sha256-FcSA72bmQVWY7i+iAqysUkfTH4FuQAEVAgG8o7lfQf0=";
      #   src = vicinaeExtensions + "/dbus";
      # })
      (config.lib.vicinae.mkExtension {
        name = "vscrot"; # screenshot
        npmDepsHash = "sha256-+x66mx89+hnBtvYptg+IGiAT+KqoJOgQYhzXhr6nS58=";
        src = vicinaeExtensions + "/vscrot";
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

        "@JaINTP/vscrot".entrypoints.scrot.alias = "screenshot";
      };
    };
  };

  wayland.windowManager.hyprland.settings = {
    "$runner" = "vicinae toggle";
    "$clipboard_manager" = "vicinae 'vicinae://launch/clipboard/history'";
    "$power_menu" = "vicinae 'vicinae://launch/power'";
    "$screenshot" = "vicinae 'vicinae://launch/@JaINTP/vscrot/scrot'";
  };

  catppuccin.vicinae.enable = true;
}
