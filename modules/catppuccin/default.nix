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
    git-delta.enable = lib.mkEnableOption "git delta integration";
    mpv.enable = lib.mkEnableOption "mpv integration";
    obs-studio.enable = lib.mkEnableOption "obs-studio integration";
    swaync.enable = lib.mkEnableOption "swaync integration";
    vesktop.enable = lib.mkEnableOption "webcord integration";
    walker.enable = lib.mkEnableOption "walker integration";
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
          substitutions = builtins.concatMap (x: [
            "--replace-quiet"
            "var(--${x})"
            "${palette.${x}.hex}"
            "--replace-quiet"
            "var(--accent)"
            "${palette.${ctp.accent}.hex}"
          ]) (builtins.attrNames colors);
        });
    in
    lib.mkIf (config.theme.catppuccin.enable) (
      lib.mkMerge [
        (lib.mkIf (cfg.waybar.enable) {
          programs.waybar.style = replaceColors ./waybar-template.css;
        })
        (lib.mkIf (cfg.swaync.enable) {
          services.swaync.style = replaceColors ./swaync-template.css;
        })
        (lib.mkIf (cfg.walker.enable) {
          xdg.configFile."walker/themes/catppuccin.css".source = replaceColors ./walker-template.css;

          xdg.configFile."walker/themes/catppuccin.json".source = ./walker-theme.json;
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
          qt.kde.settings."obs-studio/global.ini".Appearance."Theme" = "com.obsproject.Catppuccin.${upperFirst ctp.flavor}";

          xdg.configFile."obs-studio/themes" = {
            source = "${inputs.catppuccin-obs}/themes";
            recursive = true;
          };
        })

        (
          let
            theme-file = "catppuccin-${ctp.flavor}-${ctp.accent}.theme.css";
          in
          lib.mkIf (cfg.vesktop.enable) {
            xdg.configFile."vesktop/themes/${theme-file}" = {
              source = "${inputs.catppuccin-discord}/dist/${theme-file}";
            };
          }
        )

        (lib.mkIf (cfg.git-delta.enable) {
          programs.git = {
            extraConfig.delta.features = "catppuccin-${config.catppuccin.flavor}";
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
