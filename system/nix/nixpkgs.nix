{
  lib,
  pkgs,
  ...
}: {
  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      permittedInsecurePackages =
        lib.optional (pkgs.obsidian.version == "1.5.3") "electron-25.9.0";
    };
  };
}
