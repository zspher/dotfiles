{ pkgs, ... }:
let
  conditional_startup = pkgs.writers.writePython3 "conditional_startup" {
    flakeIgnore = [
    ];
  } (builtins.readFile ./scripts/conditional_startup.py);
in
{
  imports = [
    ./keybinds.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
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
        "hyprctl dispatch focusmonitor HDMI-A-1"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;

        touchpad.natural_scroll = true;

        scroll_method = "on_button_down";
        sensitivity = 0;
      };

      binds = {
        movefocus_cycles_fullscreen = true;
      };

      general = {
        gaps_in = 0;
        gaps_out = "4, 0, 0, 0";
        border_size = 1;
        "col.active_border" = "rgb($mauveAlpha)";
        "col.inactive_border" = "rgb($mantleAlpha)";
        layout = "dwindle";
        allow_tearing = true;
      };

      decoration = {
        rounding = 10;
        blur = {
          enabled = false;
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
        enabled = false;

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

      workspace = [
        "8, monitor:eDP-1, default:true"
      ];

      windowrule = [
        "border_color rgb($greenAlpha), match:fullscreen 1"
        "border_color rgb($greenAlpha), match:float 1"
        "border_color rgb($overlay2Alpha), match:xwayland 1, match:float 0, match:fullscreen 0"

        "workspace 1 silent, match:class obsidian"
        "workspace 2, match:class Brave-browser"
        "workspace 2, match:class brave-browser"
        "workspace 3, match:class Code"
        "workspace 3, match:class code-url-handler"
        "workspace 3, match:class kitty-term"
        "workspace 4 silent, match:class vesktop"
        "workspace 10, match:class spotify"
        "workspace unset, match:initial_title (about:blank - Brave)"

        "float 1, match:class brave-browser, match:title (DevTools.*)"
        "float 1, match:class org.kde.polkit-kde-authentication-agent-1"
        "float 1, match:class xdg-desktop-portal-gtk"
        "float 1, match:title (Unlock Database \- KeePassXC)"
        "float 1, match:class (net.code\-industry.masterpdfeditor4)"
        "tile 1, match:title (.*Master PDF Editor.*)"

        "no_screen_share 1, match:class (org.keepassxc.KeePassXC)"

        # "immediate, class:^(steam_app_230410)$"
      ];

      layerrule = [
        "blur 1, no_anim 1, match:namespace rofi"
        "blur 1, no_anim 1, match:namespace walker"
      ];
    };
  };
}
