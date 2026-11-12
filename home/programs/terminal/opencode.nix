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
  catppuccin.opencode.enable = true;
}
