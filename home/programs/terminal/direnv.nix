{ pkgs, config, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  xdg.configFile."direnv/stdlib.sh".source = pkgs.runCommand "direnv-stdlib.sh" { } ''
    ${config.programs.direnv.package}/bin/direnv stdlib > $out
  '';
}
