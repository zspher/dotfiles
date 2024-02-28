{
  systems = ["x86_64-linux"];

  perSystem = {
    pkgs,
    inputs',
    ...
  }: {
    packages = {
      catppuccin-obs = pkgs.callPackage ./catppuccin-obs {};
      posy-cursor = pkgs.callPackage ./posy-cursor {};
      sddm-corners-theme = pkgs.callPackage ./sddm-corners-theme {};
    };
  };
}
