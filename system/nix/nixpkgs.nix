{
  lib,
  self,
  inputs,
  ...
}: {
  nixpkgs = {
    overlays = [
      inputs.waybar.overlays.default
    ];
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [];
    };
  };
}
