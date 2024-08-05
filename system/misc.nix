{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # fonts
  fonts.packages = with pkgs; [
    (nerdfonts.override {fonts = ["CascadiaMono" "Noto"];})
  ];

  # internationalization
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "C.UTF-8";
  };

  # theme
  catppuccin.flavor = "mocha";
  catppuccin.accent = "mauve";
  console.catppuccin.enable = true;
}
