{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  # fonts
  fonts.packages = with pkgs; [
    nerd-fonts.noto
    nerd-fonts.caskaydia-mono
  ];

  # internationalization
  i18n = {
    defaultLocale = "en_CA.UTF-8";
    extraLocaleSettings = {
      LC_TIME = "en_DK.UTF-8";
    };
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_CA.UTF-8/UTF-8"
      "en_DK.UTF-8/UTF-8"
    ];
  };

  boot.supportedFilesystems = {
    btrfs = true;
    ntfs = true;
    exfat = true;
  };

}
