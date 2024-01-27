{...}: {
  imports = [
    ../modules/home-manager/catppuccin.nix
  ];
  theme.catppuccin = {
    enable = true;
    variant = "mocha";
    accent = "mauve";
  };
}
