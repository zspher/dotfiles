{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.homeModules.catppuccin
    ./kde.nix
  ];
  options.catppuccin.custom = {
    anyrun.enable = lib.mkEnableOption "anyrun";
    copyq.enable = lib.mkEnableOption "copyq integration";
    gtk.enable = lib.mkEnableOption "gtk integration";
    rofi.enable = lib.mkEnableOption "rofi integration";
    swaync.enable = lib.mkEnableOption "swaync integration";
    vesktop.enable = lib.mkEnableOption "webcord integration";
    walker.enable = lib.mkEnableOption "walker integration";
    waybar.enable = lib.mkEnableOption "waybar integration";
  };

  config =
    let
      cfg = config.catppuccin;
      upperFirst =
        str:
        (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);

      palette = (lib.importJSON "${cfg.sources.palette}/palette.json").${cfg.flavor}.colors;
      colors = builtins.mapAttrs (color: val: (builtins.substring 1 6 val.hex)) palette;

      replaceColors =
        src:
        (pkgs.substitute {
          src = src;
          substitutions =
            (builtins.concatMap (x: [
              "--replace-quiet"
              "var(--${x})"
              "${palette.${x}.hex}"
            ]) (builtins.attrNames colors))
            ++ [
              "--replace-quiet"
              "var(--accent)"
              "${palette.${cfg.accent}.hex}"
            ];
        });
    in
    lib.mkIf (cfg != { }) (
      lib.mkMerge [
        (lib.mkIf (cfg.custom.rofi.enable) {
          xdg.configFile."rofi/share/theme.rasi".source = replaceColors ./rofi-template.rasi;
        })
        (lib.mkIf (cfg.custom.waybar.enable) {
          programs.waybar.style = replaceColors ./waybar-template.css;
          programs.waybar.settings.mainBar = {
            clock.calendar.format = {
              months = lib.mkForce "<span color='#${colors.text}'><b>{}</b></span>";
              days = lib.mkForce "<span color='#${colors.text}'><b>{}</b></span>";
              weeks = lib.mkForce "<span color='#${colors.sky}'><b>W{}</b></span>";
              weekdays = lib.mkForce "<span color='#${colors.blue}'><b>{}</b></span>";
              today = lib.mkForce "<span color='#${colors.red}'><b><u>{}</u></b></span>";
            };
            cpu.format = lib.mkForce (
              lib.concatStrings [
                "<span foreground='#${colors.peach}'>{icon0}</span> "
                "<span foreground='#${colors.yellow}'>{icon1}</span> "
                "<span foreground='#${colors.yellow}'>{icon2}</span> "
                "<span foreground='#${colors.green}'>{icon3}</span>"
              ]
            );
          };
        })
        (lib.mkIf (cfg.custom.swaync.enable) {
          services.swaync.style = replaceColors ./swaync-template.css;
        })
        # (lib.mkIf (cfg.custom.walker.enable) {
        #   programs.walker = {
        #     config.theme = "catppuccin";
        #     themes."catppuccin" = {
        #       style = builtins.readFile (replaceColors ./walker-template.css);
        #     };
        #   };
        # })
        (lib.mkIf (cfg.custom.anyrun.enable) {
          xdg.configFile."anyrun/style.css".source = replaceColors ./anyrun-template.css;
        })

        (lib.mkIf (cfg.custom.gtk.enable) {
          gtk = {
            enable = true;
            theme =
              let
                colorVariants = if cfg.flavor == "latte" then [ "light" ] else [ "dark" ];
                ctpToCollMap = {
                  mauve = "purple";
                  maroon = "red";
                  peach = "orange";

                  pink = "pink";
                  blue = "blue";
                  teal = "teal";
                  green = "green";
                  yellow = "yellow";
                };

                ctpToColl =
                  color:
                  if builtins.hasAttr color ctpToCollMap then
                    ctpToCollMap.${color}
                  else
                    builtins.throw "invalid color: ${color}";
                ac = cfg.accent;
              in
              {
                name = "Colloid-${upperFirst (ctpToColl ac)}-Dark-Catppuccin";
                package = pkgs.colloid-gtk-theme.override {
                  inherit colorVariants;
                  themeVariants = [ "${ctpToColl ac}" ];
                  sizeVariants = [ "standard" ];
                  tweaks = [
                    "catppuccin"
                    "black"
                  ];
                };
              };
          };
        })

        (lib.mkIf (cfg.mpv.enable) {
          programs.mpv.scriptOpts.uosc = {
            chapter_ranges = lib.concatStrings [
              "intros:${colors.blue},"
              "outros:${colors.blue},"
              "openings:${colors.blue},"
              "endings:${colors.blue},"
              "ads:${colors.red}"
            ];
          };
        })

        (lib.mkIf (cfg.obs.enable) {
          qt.kde.settings."obs-studio/global.ini".Appearance."Theme" =
            "com.obsproject.Catppuccin.${upperFirst cfg.flavor}";
        })

        (lib.mkIf (cfg.custom.vesktop.enable) {
          programs.vesktop.vencord.settings.themeLinks = [
            "https://catppuccin.github.io/discord/dist/catppuccin-${cfg.flavor}-mauve.theme.css"
          ];
        })

        (lib.mkIf (cfg.delta.enable) {
          programs.bat = {
            enable = true;
          };
        })

        (lib.mkIf (cfg.zathura.enable) {
          programs.zathura.options = {
            recolor = false;
            render-loading-bg = "#ffffff";
            highlight-fg = "${palette.base.hex}";
          };
        })

        (lib.mkIf (cfg.custom.copyq.enable) {
          qt.kde.settings =
            let
              data = {
                edit_bg = palette.base.hex;
                edit_fg = palette.text.hex;

                bg = palette.base.hex;
                alt_bg = palette.base.hex;
                fg = palette.text.hex;

                find_bg = palette.peach.hex;
                find_fg = palette.base.hex;

                notes_bg = palette.base.hex;
                notes_fg = palette.text.hex;
                notification_bg = palette.base.hex;
                notification_fg = palette.text.hex;

                sel_fg = palette.text.hex;
                sel_bg = "#50${colors.overlay0}";
                hover_item_css = "\"background: #80${colors.overlay1}\"";

                css_template_items = "items";
                css_template_main_window = "main_window";
                css_template_menu = "menu";
                css_template_notification = "notification";
                font_antialiasing = "true";
                icon_size = "16";

                num_fg = "default_placeholder_text";
                num_margin = "2";

                show_number = "true";
                show_scrollbars = "true";
                style_main_window = "false";
                use_system_icons = "false";
              };
            in
            {
              "copyq/themes/catppuccin.ini".General = data;
              "copyq/copyq.conf".Theme = data;
            };
        })
      ]
    );
}
