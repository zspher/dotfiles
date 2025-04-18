{
  pkgs,
  config,
  lib,
  ...
}:
let
  inherit (lib.meta) getExe getExe';
in
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 38;
        output = [ "*" ];
        modules-left = [
          "group/power"
          "hyprland/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [
          "privacy"
          "clock"
          "idle_inhibitor"
        ];
        modules-right = [
          "battery"
          "pulseaudio"
          "cpu"
          "memory"
          "temperature"
          "custom/notification"
          "tray"
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
          path = "${./icons/nix-catppuccin-logo.svg}";
        };
        "custom/power" = {
          format = "";
          on-click = "shutdown now";
          tooltip-format = "shutdown";
        };
        "custom/quit" = {
          format = "󰗼";
          on-click = "hyprctl dispatch exit";
          tooltip-format = "quit";
        };
        "custom/lock" = {
          format = "󰍁";
          on-click = "hyprlock";
          tooltip-format = "lock";
        };
        "custom/reboot" = {
          format = "󰜉";
          on-click = "reboot";
          tooltip-format = "reboot";
        };
        "custom/hibernate" = {
          format = "";
          on-click = "systemctl hibernate";
          tooltip-format = "hibernate";
        };

        "hyprland/workspaces" = {
          format = "<b>{icon}</b>";
          on-click = "activate";
          sort-by-number = true;
        };

        "wlr/taskbar" = {
          format = "{icon}●";
          icon-size = 11;
          icon-theme = "Papirus-Dark";
          markup = true;
          tooltip-format = "<span size='medium' weight='bold'>{title}</span>\n<small>{app_id}</small>";
          on-click = "activate";
          on-click-middle = "close";
          ignore-list = [ ];
          app_ids-mapping = { };
        };

        # * center  * //
        privacy = {
          icon-size = 12;
          icon-spacing = 5;
        };

        clock = {
          format = "{:%H:%M | %a %d}";
          format-alt = "{:%A %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#cdd6f4'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#89dceb'><b>W{}</b></span>";
              weekdays = "<span color='#89b4fa'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
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
            activated = "󰒳";
            deactivated = "󰰄";
          };
        };

        # * left side  * //

        battery = {
          bat = "BAT1";
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "<span foreground='#b4befe'>{capacity}% {icon} {power} W</span>";
          format-charging = "<span foreground='#a6e3a1'>{capacity}% {icon}󱐋</span>";
          format-critical = "<span foreground='#f38ba8'>{capacity}% 󱃌 {power} W</span>";
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
        };

        pulseaudio = {
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
          format = "<span foreground='#fab387'>{icon0}</span> <span foreground='#f9e2af'>{icon1}</span> <span foreground='#f9e2af'>{icon2}</span> <span foreground='#a6e3a1'>{icon3}</span>";
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
            "<span foreground='#89b4fa'></span>"
            ""
            "<span foreground='#f38ba8'></span>"
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
          icon-size = 11;
          spacing = 10;
          show-passive-items = true;
        };
      };
    };
    systemd.enable = true;
  };
  # FIX: https://github.com/nix-community/home-manager/issues/4099
  systemd.user.services.waybar.Service.Environment =
    lib.mkForce "PATH=${config.home.profileDirectory}/bin";
}
