{
  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    packages = {
      catppuccin-obs = pkgs.callPackage ./catppuccin-obs {};
      posy-cursor = pkgs.callPackage ./posy-cursor {};
      sddm-corners-theme = pkgs.callPackage ./sddm-corners-theme {};
      fotokilof = pkgs.python311Packages.callPackage ./fotokilof {};
    };
  };
}
