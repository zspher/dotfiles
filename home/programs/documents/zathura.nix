{ pkgs, ... }:
{
  programs.zathura = {
    enable = true;
    options = {
      recolor-keephue = true;
      selection-clipboard = "clipboard";
      synctex-editor-command = "${pkgs.texlab}/bin/texlab inverse-search -i %{input} -l %{line}";
    };
  };
}
