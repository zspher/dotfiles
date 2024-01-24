{...}: {
  programs.kitty = {
    enable = true;
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

  };
}
