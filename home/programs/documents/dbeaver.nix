{ pkgs, lib, ... }:
let
  font = {
    regular = "1|Sans|9.0|0|GTK|1|;";
    mono = "1|CaskaydiaMono Nerd Font Mono|10.0|0|GTK|1|;";
  };

in
{
  programs.dbeaver = {
    enable = true;
    settings = {
      "org.eclipse.ui.workbench" = {
        "org.eclipse.compare.contentmergeviewer.TextMergeViewer" = font.mono;
        "org.eclipse.jface.dialogfont" = font.regular;
        "org.eclipse.jface.textfont" = font.mono;
        "org.eclipse.ui.workbench.TAB_TEXT_FONT" = font.regular;
        "org.eclipse.ui.workbench.TREE_TABLE_FONT" = font.regular;
        "org.eclipse.ui.workbench.texteditor.blockSelectionModeFont" = font.mono;
        "org.jkiss.dbeaver.dbeaver.ui.fonts.main" = font.regular;
        "org.jkiss.dbeaver.dbeaver.ui.fonts.monospace" = font.mono;
        "org.jkiss.dbeaver.sql.resultset.font" = font.regular;
      };
    };
  };
}
