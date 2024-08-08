{
  config,
  lib,
  pkgs,
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

    replaceColors = src:
      builtins.readFile (pkgs.substitute {
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
          programs.anyrun.extraCss = replaceColors ./anyrun-template.css;
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

        (let
          # TODO: switch to main catppuccin repo when my fix is merged
          catppuccin-obs = pkgs.fetchFromGitHub {
            owner = "zspher";
            repo = "obs";
            rev = "7705e980bd43c8f5af95162af71ac0c4d830877d";
            hash = "sha256-j905gMz6ieVFaaSv00S5ANKwlQGqa0v9qwxwgzt2V0o=";
          };
        in
          mkIf (cfg.obs-studio.enable) {
            qt.kde.settings."obs-studio/global.ini".Appearance."Theme" = "com.obsproject.Catppuccin.${upperFirst ctp.flavor}";

            xdg.configFile."obs-studio/themes" = {
              source = "${catppuccin-obs}/themes";
              recursive = true;
            };
          })

        (let
          catppuccin-discord = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "discord";
            rev = "7c2c42e5e6fe0e9949ecdd0e594282f01e9d3217";
            hash = "sha256-wAfF3VId5yJtstfkmHojSQ8xTQRB9Vw7iKTUrPxZPv4=";
          };
          theme-file = "catppuccin-${ctp.flavor}-${ctp.accent}.theme";
        in
          lib.mkIf (cfg.webcord.enable) {
            xdg.configFile."WebCord/Themes/${theme-file}" = {
              source = "${catppuccin-discord}/dist/${theme-file}.css";
            };
          })
      ]
    );
}
