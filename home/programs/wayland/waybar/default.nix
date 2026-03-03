{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.meta) getExe getExe';
  pkexec = "/run/wrappers/bin/pkexec";
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        output = [ "*" ];
        modules-left = [
          "group/power"
          "hyprland/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [
          "privacy"
          "group/middle"
        ];
        modules-right = [
          "battery"
          "group/hardware"
          "group/control"
        ];

        # * left side * //
        #
        "group/power" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "power";
            transition-left-to-right = true;
          };
          modules = [
            "image#logo"
            "custom/power"
            "custom/quit"
            "custom/lock"
            "custom/reboot"
            "custom/hibernate"
          ];
        };

        "image#logo" = {
          # path = "~/.config/waybar/assets/nix-catppuccin-logo.svg";
          path = "${./assets/nix-catppuccin-logo.svg}";
          # FIX: high cpu due images polling a lot if interval is null
          # https://github.com/Alexays/Waybar/issues/4835
          interval = "once";
        };
        "custom/power" = {
          format = "";
          on-click = "${getExe' pkgs.systemd "systemctl"} poweroff";
          tooltip-format = "poweroff";
        };
        "custom/quit" = {
          format = "󰗼";
          on-click = "${getExe' pkgs.hyprland "hyprctl"} dispatch exit";
          tooltip-format = "quit";
        };
        "custom/lock" = {
          format = "󰍁";
          on-click = "${getExe' pkgs.systemd "loginctl"} lock-session";
          tooltip-format = "lock";
        };
        "custom/reboot" = {
          format = "󰜉";
          on-click = "${getExe' pkgs.systemd "systemctl"} reboot";
          tooltip-format = "reboot";
        };
        "custom/hibernate" = {
          format = "";
          on-click = "${getExe' pkgs.systemd "systemctl"} hibernate";
          tooltip-format = "hibernate";
        };

        "hyprland/workspaces" = {
          format = "<b>{icon}</b>";
          on-click = "activate";
          sort-by-number = true;
        };

        "wlr/taskbar" = {
          format = "{icon}";
          icon-size = 14;
          icon-theme = "Papirus-Dark";
          tooltip-format = "{title}\n{app_id}";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [ ];
          app_ids-mapping = { };
        };

        # * center  * //
        "group/middle" = {
          modules = [
            "clock"
            "idle_inhibitor"
          ];
          orientation = "inherit";
        };
        privacy = {
          icon-size = 12;
          icon-spacing = 5;
        };

        clock = {
          format = "{:%H:%M • %a %d}";
          format-alt = "{:%A %B %d, %Y (%R)}";
          tooltip-format = "<tt>{calendar}</tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<b>{}</b>";
              days = "<b>{}</b>";
              weeks = "<b>W{}</b>";
              weekdays = "<b>{}</b>";
              today = "<b><u>{}</u></b>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰰄";
            deactivated = "󰰅";
          };
        };

        # * left side  * //

        "group/hardware" = {
          modules = [
            "wireplumber"
            "cpu"
            "memory"
            "temperature"
          ];
          orientation = "inherit";
        };

        "group/control" = {
          modules = [
            "custom/notification"
            "tray"
          ];
          orientation = "inherit";
        };

        battery = {
          bat = "BAT1";
          interval = 10;
          states = {
            warning = 25;
            critical = 20;
          };
          format = "{capacity}% {icon} {power} W";
          format-charging = "{capacity}% {icon}󱐋";
          format-critical = "{capacity}% 󱃌 {power} W";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          max-length = 25;
          menu = "on-click";
          menu-file = "~/.config/waybar/assets/battery_menu.xml";
          menu-actions = {
            default = "${pkexec} ${getExe pkgs.auto-cpufreq} --force=reset";
            powersave = "${pkexec} ${getExe pkgs.auto-cpufreq} --force=powersave";
            performance = "${pkexec} ${getExe pkgs.auto-cpufreq} --force=performance";
          };
        };

        wireplumber = {
          scroll-step = 1;
          reverse-scrolling = 1;
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = " ";
            hands-free = "";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = " ";
            default = [
              ""
              ""
              " "
            ];
          };
          on-click = "${getExe pkgs.pavucontrol}";
        };
        cpu = {
          format = "{icon0} {icon1} {icon2} {icon3}";
          format-icons = [
            "▁"
            "▂"
            "▃"
            "▄"
            "▅"
            "▆"
            "▇"
            "█"
          ];
        };
        memory = {
          format = "{}% ";
        };
        temperature = {
          thermal-zone = 1;
          critical-threshold = 80;
          format = "{temperatureC}°C {icon}";
          format-icons = [
            ""
            ""
            ""
          ];
        };
        "custom/notification" = {
          escape = true;
          format = "{icon}";
          format-icons = {
            dnd-inhibited-none = "󱙍";
            dnd-inhibited-notification = "󱙍<span foreground='red'><sup></sup></span>";
            dnd-none = "󱙍";
            dnd-notification = "󱙍<span foreground='red'><sup></sup></span>";
            inhibited-none = "󰍡";
            inhibited-notification = "󰍡<span foreground='red'><sup></sup></span>";
            none = "󰍡";
            notification = "󰍡<span foreground='red'><sup></sup></span>";
          };
          exec = "${getExe' pkgs.swaynotificationcenter "swaync-client"} -swb";
          on-click = "${getExe' pkgs.swaynotificationcenter "swaync-client"} -t -sw";
          on-click-right = "${getExe' pkgs.swaynotificationcenter "swaync-client"} -d -sw";
          return-type = "json";
          tooltip = true;
        };
        tray = {
          icon-size = 12;
          spacing = 10;
          show-passive-items = true;
        };
      };
    };
    systemd.enable = true;
  };
  xdg.configFile."waybar/assets" = {
    source = ./assets;
    recursive = true;
  };
  # FIX: https://github.com/nix-community/home-manager/issues/4099
  systemd.user.services.waybar.Service.Environment =
    lib.mkForce "PATH=${config.home.profileDirectory}/bin";
}
