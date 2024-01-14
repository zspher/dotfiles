{data, ...}: let
  inherit (data) username;
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
}
