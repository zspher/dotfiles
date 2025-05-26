{ pkgs, ... }:
let
  conditional_startup = pkgs.writers.writePython3 "conditional_startup" {
    flakeIgnore = [
    ];
  } (builtins.readFile ./scripts/conditional_startup.py);
in
{
  imports = [
    ./clipboard.nix
    ./keybinds.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    systemd.variables = [
      "DISPLAY"
      "HYPRLAND_INSTANCE_SIGNATURE"
      "WAYLAND_DISPLAY"
      "XDG_CURRENT_DESKTOP"
      "QT_QPA_PLATFORM"
    ];
    settings = {
      source = [ "~/.config/hypr/monitors.conf" ];
      env = [ "QT_QPA_PLATFORM,wayland" ];

      exec-once = [
        "${conditional_startup}"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;

        touchpad.natural_scroll = true;

        scroll_method = "on_button_down";
        sensitivity = 0;
      };

      general = {
        gaps_in = 2;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgb($mauveAlpha)";
        "col.inactive_border" = "rgb($mantleAlpha)";
        layout = "dwindle";
        allow_tearing = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

        shadow = {
          enabled = false;
          range = 8;
          render_power = 2;
          offset = "2 3";

          color = "rgb($mauveAlpha)";
          color_inactive = "rgb($crustAlpha)";
        };
      };

      animations = {
        enabled = true;

        bezier = [
          "easeInSine, 0.12, 0, 0.39, 0"
          "easeOutSine, 0.61, 1, 0.88, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 7, easeOutExpo"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, easeOutSine"
          "workspaces, 1, 5, default"
        ];
      };

      dwindle.pseudotile = true;
      dwindle.preserve_split = true;

      gestures.workspace_swipe = true;

      group = {
        "col.border_active" = "rgb($mauveAlpha)";
        "col.border_inactive" = "rgb($surface0Alpha)";
        "col.border_locked_active" = "rgb($blueAlpha)";
        "col.border_locked_inactive" = "rgb($mantleAlpha)";

        groupbar = {
          height = 10;
          render_titles = true;
          "col.active" = "rgb($surface1Alpha)";
          "col.inactive" = "rgb($surface0Alpha)";
          "col.locked_active" = "rgb($blueAlpha)";
          "col.locked_inactive" = "rgb($mantleAlpha)";
        };
      };

      xwayland = {
        force_zero_scaling = true;
      };

      misc = {
        # vrr = 2;
        force_default_wallpaper = 0;
        anr_missed_pings = 10;
      };

      windowrule = [
        "bordercolor rgb($greenAlpha), fullscreen:1"
        "bordercolor rgb($greenAlpha), floating:1"
        "bordercolor rgb($overlay2Alpha), xwayland:1, floating:0, fullscreen:0"

        "workspace 1, class:obsidian"
        "workspace 2, class:Brave-browser"
        "workspace 2, class:brave-browser"
        "workspace 3, class:Code"
        "workspace 3, class:code-url-handler"
        "workspace 3, class:kitty-term"
        "workspace 4, class:vesktop"

        "float, title:^(Floating Window \- Show Me The Key)$"
        "noborder, title:^(Floating Window \- Show Me The Key)$"
        "move 100%-320 100%-200, title:^(Floating Window \- Show Me The Key)$"
        "nofocus, title:^(Floating Window \- Show Me The Key)$"
        "noanim, title:^(Floating Window \- Show Me The Key)$"
        "pin, title:^(Floating Window \- Show Me The Key)$"

        "float, class:brave-browser, title:^(DevTools.*)$"
        "float, class:^(org.kde.polkit-kde-authentication-agent-1)$"
        "float, class:xdg-desktop-portal-gtk"
        "float, title:^(Unlock Database \- KeePassXC)$"
        "float, class:^(net.code\-industry.masterpdfeditor4)$"
        "tile, title:^(.*Master PDF Editor.*)$"

        "noblur, xwayland:1, title:" # brave pop-up (i.e. app menu, right click pop-up)

        # "immediate, class:^(steam_app_230410)$"
      ];

      layerrule = [
        "noanim, ^(rofi)$"
        "ignorezero, ^(rofi)$"
        "blur, ^(rofi)$"
        "noanim, ^(walker)$"
      ];
    };
  };
}
