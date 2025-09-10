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
        })
        (lib.mkIf (cfg.custom.swaync.enable) {
          services.swaync.style = replaceColors ./swaync-template.css;
        })
        (lib.mkIf (cfg.custom.walker.enable) {
          programs.walker.theme = {
            name = "catppuccin";
            style = builtins.readFile (replaceColors ./walker-template.css);
          };
        })
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
      ]
    );
}
