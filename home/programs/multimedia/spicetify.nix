{
  inputs,
  pkgs,
  config,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = config.catppuccin.flavor;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
    ];
  };
}
