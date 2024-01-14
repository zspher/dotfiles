{home-manager}: {
  mkHMuser = {
    username,
    pkgs,
    modules ? [],
  }:
    home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules =
        [
          {
            home = {
              inherit username;
              homeDirectory = "/home/${username}";
            };
          }
        ]
        ++ modules;
    };
}
