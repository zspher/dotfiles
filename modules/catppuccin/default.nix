{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.theme.catppuccin;

  upperFirst = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {
  imports = [
    ./kde.nix
  ];
  options.theme.catppuccin = {
    enable = lib.mkEnableOption "catppuccin";

    anyrun.enable = lib.mkEnableOption "anyrun integration";
    git-delta.enable = lib.mkEnableOption "git delta integration";
    kvantum.enable = lib.mkEnableOption "kvantum integration";
    mpv.enable = lib.mkEnableOption "mpv integration";
    obs-studio.enable = lib.mkEnableOption "obs-studio integration";
    swaync.enable = lib.mkEnableOption "swaync integration";
    waybar.enable = lib.mkEnableOption "waybar integration";
    webcord.enable = lib.mkEnableOption "webcord integration";
  };

  config = let
    ctp = {inherit (config.catppuccin) sources flavor accent;};
    catppuccin = pkgs.catppuccin.override {
      inherit (ctp) accent;
      variant = ctp.flavor;
    };

    kvantum-theme = "Catppuccin-${upperFirst ctp.flavor}-${upperFirst ctp.accent}";
    palette = (lib.importJSON "${ctp.sources.palette}/palette.json").${ctp.flavor}.colors;
    colors = builtins.mapAttrs (color: val: (builtins.substring 1 6 val.hex)) palette;

    replaceColors = src: (pkgs.substitute {
      src = src;
      substitutions =
        builtins.concatMap (x: ["--replace-quiet" "var(--${x})" "${palette.${x}.hex}"])
        (builtins.attrNames colors);
    });
  in
    lib.mkIf cfg.enable (
      lib.mkMerge [
        (lib.mkIf cfg.kvantum.enable {
          xdg.configFile = {
            "Kvantum/${kvantum-theme}".source = "${catppuccin}/share/Kvantum/${kvantum-theme}";
            "Kvantum/kvantum.kvconfig".text = lib.generators.toINI {} {
              General.theme = "${kvantum-theme}";
            };
          };
        })

        (lib.mkIf (cfg.anyrun.enable) {
          xdg.configFile."anyrun/style.css".source = replaceColors ./anyrun-template.css;
        })
        (lib.mkIf (cfg.waybar.enable) {
          programs.waybar.style = replaceColors ./waybar-template.css;
        })
        (lib.mkIf (cfg.swaync.enable) {
          services.swaync.style = replaceColors ./swaync-template.css;
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

        (let
          theme-file = "catppuccin-${ctp.flavor}-${ctp.accent}.theme";
        in
          lib.mkIf (cfg.webcord.enable) {
            xdg.configFile."WebCord/Themes/${theme-file}" = {
              source = "${inputs.catppuccin-discord}/dist/${theme-file}.css";
            };
          })

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
