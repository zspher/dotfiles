{
  inputs,
  pkgs,
  config,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = config.catppuccin.flavour;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
    ];
  };
}
