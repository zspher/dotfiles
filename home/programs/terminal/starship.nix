{ lib, ... }:
{
  programs.starship = {
    enable = true;
    enableTransience = true;
    settings = {
      format = lib.concatStrings [
        "$time"
        "$all"
        "$shell"
        "$character"
      ];
      shell = {
        fish_indicator = "⥽ ";
        powershell_indicator = ">_";
        bash_indicator = "\$_";
        zsh_indicator = "z ";
        unknown_indicator = "⁇";
        style = "cyan bold";
        disabled = false;
      };
      time = {
        style = "yellow";
        use_12hr = true;
        disabled = false;
        format = "[\\[$time\\]]($style) ";
        time_format = "%R";
      };
    };
  };
}
