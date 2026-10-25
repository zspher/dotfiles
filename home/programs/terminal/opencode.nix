{ config, ... }:

let
  themeName =
    if config.catppuccin.opencode.flavor == "frappe" then
      "catppuccin-frappe"
    else if config.catppuccin.opencode.flavor == "macchiato" then
      "catppuccin-macchiato"
    else
      "catppuccin"; # Default for mocha and latte
in

{
  programs.opencode.enable = true;
  programs.opencode.cli = {
    theme.name = themeName;
  };
  # catppuccin.opencode.enable = true; # TODO: remove when catppuccin/nix updates
}
