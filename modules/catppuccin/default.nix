{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.theme.catppuccin;

  upperFirst =
    str:
    (lib.toUpper (builtins.substring 0 1 str)) + (builtins.substring 1 (builtins.stringLength str) str);
in
{
  imports = [
    ./kde.nix
  ];
  options.theme.catppuccin = {
    enable = lib.mkEnableOption "catppuccin";
    anyrun.enable = lib.mkEnableOption "anyrun";
    git-delta.enable = lib.mkEnableOption "git delta integration";
    gtk.enable = lib.mkEnableOption "gtk integration";
    mpv.enable = lib.mkEnableOption "mpv integration";
    obs-studio.enable = lib.mkEnableOption "obs-studio integration";
    rofi.enable = lib.mkEnableOption "rofi integration";
    swaync.enable = lib.mkEnableOption "swaync integration";
    vesktop.enable = lib.mkEnableOption "webcord integration";
    # walker.enable = lib.mkEnableOption "walker integration";
    waybar.enable = lib.mkEnableOption "waybar integration";
  };

  config =
    let
      ctp = {
        inherit (config.catppuccin) sources flavor accent;
      };
      catppuccin = pkgs.catppuccin.override {
        inherit (ctp) accent;
        variant = ctp.flavor;
      };

      palette = (lib.importJSON "${ctp.sources.palette}/palette.json").${ctp.flavor}.colors;
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
              "${palette.${ctp.accent}.hex}"
            ];
        });
    in
    lib.mkIf (config.theme.catppuccin.enable) (
      lib.mkMerge [
        (lib.mkIf (cfg.rofi.enable) {
          xdg.configFile."rofi/share/theme.rasi".source = replaceColors ./rofi-template.rasi;
        })
        (lib.mkIf (cfg.waybar.enable) {
          programs.waybar.style = replaceColors ./waybar-template.css;
        })
        (lib.mkIf (cfg.swaync.enable) {
          services.swaync.style = replaceColors ./swaync-template.css;
        })
        # (lib.mkIf (cfg.walker.enable) {
        #   xdg.configFile."walker/themes/catppuccin.css".source = replaceColors ./walker-template.css;
        #   xdg.configFile."walker/themes/catppuccin.toml".source = replaceColors ./walker-theme.toml;
        #   programs.walker.config.theme = "catppuccin";
        # })
        (lib.mkIf (cfg.anyrun.enable) {
          xdg.configFile."anyrun/style.css".source = replaceColors ./anyrun-template.css;
        })

        (lib.mkIf (cfg.gtk.enable) {
          gtk = {

            enable = true;

            theme =
              let
                colorVariants = if ctp.flavor == "latte" then [ "light" ] else [ "dark" ];
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
                ac = ctp.accent;
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

        (lib.mkIf (cfg.obs-studio.enable) {
          qt.kde.settings."obs-studio/global.ini".Appearance."Theme" =
            "com.obsproject.Catppuccin.${upperFirst ctp.flavor}";
        })

        (lib.mkIf (cfg.vesktop.enable) {
          programs.vesktop.vencord.settings.themeLinks = [
            "https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css"
          ];
        })

        (lib.mkIf (cfg.git-delta.enable) {
          programs.git = {
            extraConfig.delta.features = "catppuccin-${ctp.flavor}";
            includes = [
              {
                path = "${inputs.catppuccin-delta}/catppuccin.gitconfig";
              }
            ];
          };
          # bat cache & catppuccin/bat is needed to theme delta
          programs.bat = {
            enable = true;
          };
        })
      ]
    );
}
