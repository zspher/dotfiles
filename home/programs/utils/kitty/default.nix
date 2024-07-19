{lib, ...}: {
  programs.kitty = {
    enable = true;
    font.name = "CaskaydiaMono Nerd Font";
    shellIntegration.mode = "no-title";
    settings = {
      disable_ligatures = "always";

      cursor_shape = "beam";

      scrollback_pager = lib.concatStrings [
        "nvim -R -M "
        "--cmd 'lua vim.g.kitty_pager = true' "
        "-c 'lua require(\"kitty-pager\")(INPUT_LINE_NUMBER, CURSOR_LINE, CURSOR_COLUMN)' -"
      ];
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

      enabled_layouts = "splits,all";

      tab_bar_edge = "bottom";
      tab_bar_style = "separator";
      tab_bar_min_tabs = 1;
      tab_activity_symbol = "●";
      tab_separator = "' '";
      tab_powerline_style = "angled";
      tab_bar_background = "#313244";

      tab_title_template = lib.concatStrings [
        "{fmt.bg._89B4FA}{fmt.fg._1E1E2E} {index} "
        "{fmt.bg._313244}{fmt.fg.tab} {title} "
        "{activity_symbol}"
      ];

      active_tab_title_template = lib.concatStrings [
        "{fmt.bg._A6E3A1} {index} "
        "{fmt.bg._11111B}{fmt.fg._CDD6F4} {title} "
        "{fmt.fg._74C7EC}{layout_name[:2].upper()} {activity_symbol}{fmt.bg.tab}"
      ];
      background_opacity = "0.9";
      dynamic_background_opacity = true;
    };

    keybindings = {
      "shift+alt+t" = "new_tab_with_cwd";
      "ctrl+shift+enter" = "launch --cwd=current --location hsplit";

      # tab
      "ctrl+space>1" = "goto_tab 1";
      "ctrl+space>2" = "goto_tab 2";
      "ctrl+space>3" = "goto_tab 3";
      "ctrl+space>4" = "goto_tab 4";
      "ctrl+space>5" = "goto_tab 5";
      "ctrl+space>6" = "goto_tab 6";
      "ctrl+space>7" = "goto_tab 7";
      "ctrl+space>8" = "goto_tab 8";
      "ctrl+space>9" = "goto_tab 9";
      "ctrl+space>t" = "new_tab";

      # window
      "ctrl+space>\"" = "launch --cwd=current --location hsplit";
      "ctrl+space>%" = "launch --cwd=current --location vsplit";
      "ctrl+space>x" = "close_window";

      "ctrl+alt+m" = "toggle_layout stack";
      "ctrl+alt+l" = "toggle_layout tall";
      "ctrl+alt+f" = "toggle_layout fat";
      "ctrl+alt+g" = "toggle_layout grid";
    };
  };
}
