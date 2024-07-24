{
  config,
  lib,
  pkgs,
  self,
  ...
}:
with lib; let
  cfg = config.theme.catppuccin;

  upperFirst = str:
    (lib.toUpper (builtins.substring 0 1 str))
    + (builtins.substring 1 (builtins.stringLength str) str);
in {
  imports = [
    ./kde.nix
  ];
  options.theme.catppuccin = {
    enable = mkEnableOption "catppuccin";

    kvantum.enable = mkEnableOption "kvantum integration";
    anyrun.enable = mkEnableOption "anyrun integration";
    waybar.enable = mkEnableOption "waybar integration";
    swaync.enable = mkEnableOption "swaync integration";
    mpv.enable = mkEnableOption "mpv integration";
    obs-studio.enable = mkEnableOption "obs-studio integration";
  };

  config = let
    ctp = {inherit (config.catppuccin) sources flavor accent;};
    catppuccin-obs = self.packages.${pkgs.system}.catppuccin-obs;
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
    mkIf cfg.enable (
      mkMerge [
        (mkIf cfg.kvantum.enable {
          xdg.configFile = {
            "Kvantum/${kvantum-theme}".source = "${catppuccin}/share/Kvantum/${kvantum-theme}";
            "Kvantum/kvantum.kvconfig".text = generators.toINI {} {
              General.theme = "${kvantum-theme}";
            };
          };
        })

        (mkIf (cfg.anyrun.enable) {
          programs.anyrun.extraCss = replaceColors ./anyrun-template.css;
        })
        (mkIf (cfg.waybar.enable) {
          programs.waybar.style = replaceColors ./waybar-template.css;
        })
        (mkIf (cfg.swaync.enable) {
          services.swaync.style = replaceColors ./swaync-template.css;
        })
        (mkIf (cfg.mpv.enable) {
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

        (mkIf (cfg.obs-studio.enable) {
          home.packages = [
            catppuccin-obs
          ];

          qt.kde.settings."obs-studio/global.ini".General."CurrentTheme3" = "Catppuccin ${upperFirst ctp.flavor}";

          xdg.configFile."obs-studio/themes" = {
            source = "${catppuccin-obs}/themes";
            recursive = true;
          };
        })
      ]
    );
}
