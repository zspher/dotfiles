{
  lib,
  pkgs,
  ...
}: {
  nixpkgs = {
    overlays = [];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
    };
  };
}
