{
  self,
  inputs,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    username = "faust";
    specialArgs = {inherit inputs self username;};
  in {
    pc = nixosSystem {
      inherit specialArgs;
      modules = [
        ./pc
        {system.stateVersion = "23.11";}
      ];
    };
    pi = nixosSystem {
      inherit specialArgs;
      modules = [
        ./pi
        {system.stateVersion = "23.11";}
      ];
    };
  };
}
