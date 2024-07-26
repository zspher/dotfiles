{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    inherit (import ../config.nix) username;
    specialArgs = {inherit inputs self username;};
  in {
    "c-100" = nixosSystem {
      inherit specialArgs;
      modules = [
        ./pc
        {system.stateVersion = "23.11";}
      ];
    };
    "ls-2100" = nixosSystem {
      inherit specialArgs;
      modules = [
        ./laptop
        {system.stateVersion = "23.11";}
      ];
    };
    "ns-200" = nixosSystem {
      inherit specialArgs;
      modules = [
        ./pi
        {system.stateVersion = "23.11";}
      ];
    };
  };
}
