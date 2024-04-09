{...}: {
  programs.kitty = {
    enable = true;
    font.name = "CaskaydiaMono Nerd Font";
    shellIntegration.mode = "no-rc no-title";
    settings = {
      disable_ligatures = "always";

      cursor_shape = "beam";

      scrollback_pager = "nvim -u NONE -R -M -c 'lua require(\"kitty-pager\")(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)' -";
      scrollback_pager_history_size = 15;

      copy_on_select = true;

      enable_audio_bell = false;
      bell_on_tab = " 🔔 ";

      remember_window_size = false;
      initial_window_width = "100c";
      initial_window_height = "25c";
      window_resize_step_cells = 2;
      window_resize_step_lines = 2;
      window_border_width = "0.5pt";

      tab_bar_edge = "top";
      tab_bar_style = "powerline";
      tab_bar_min_tabs = 1;
      tab_powerline_style = "angled";
      tab_activity_symbol = "●";
      tab_title_template = "{activity_symbol} {index}:{f'{title[title.rfind(\"/\")+1:]}' if title.rfind(\"/\") > 0 else title}";
      active_tab_title_template = "{index}:{title} {fmt.fg.blue}{layout_name[:2].upper()}{fmt.bg.tab}";

      background_opacity = "0.9";
      dynamic_background_opacity = true;
    };

    keybindings = {
      "shift+alt+enter" = "launch --cwd=current";
      "shift+alt+t" = "new_tab_with_cwd";

      "ctrl+alt+1" = "goto_tab 1";
      "ctrl+alt+2" = "goto_tab 2";
      "ctrl+alt+3" = "goto_tab 3";
      "ctrl+alt+4" = "goto_tab 4";
      "ctrl+alt+5" = "goto_tab 5";
      "ctrl+alt+6" = "goto_tab 6";
      "ctrl+alt+7" = "goto_tab 7";
      "ctrl+alt+8" = "goto_tab 8";
      "ctrl+alt+9" = "goto_tab 9";

      "ctrl+alt+m" = "toggle_layout stack";
      "ctrl+alt+l" = "toggle_layout tall";
      "ctrl+alt+f" = "toggle_layout fat";
      "ctrl+alt+g" = "toggle_layout grid";
    };
  };
}
