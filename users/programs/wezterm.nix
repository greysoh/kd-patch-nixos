{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      -- font settings
      config.font = wezterm.font_with_fallback({
        "Miracode",
        "term",
        -- "dreamers",
        --  'kyo',
        --  'Envy Code R',
      })
      config.font_size = 13.0

      config.enable_wayland = true

      -- tab bar settings
      config.enable_tab_bar = true
      config.hide_tab_bar_if_only_one_tab = true
      config.use_fancy_tab_bar = false
      config.show_tab_index_in_tab_bar = true

      -- window settings
      config.window_padding = {
        left = "10pt",
        right = "10pt",
        top = "10pt",
        bottom = "10pt",
      }
      config.window_background_opacity = 1.00
      config.default_cursor_style = "SteadyBar"

      -- -- color settings
      -- config.colors = {
      --   foreground = '#e8e3e3',
      --   background = '#151515',
      --
      --   cursor_bg = '#e8e3e3',
      --   cursor_fg = '#151515',
      --   cursor_border = '#e8e3e3',
      --
      --   selection_fg = '#151515',
      --   selection_bg = '#e8e3e3',
      --
      --   ansi = {
      --     '#151515',
      --     '#B66467',
      --     '#8C977D',
      --     '#D9BC8C',
      --     '#8DA3B9',
      --     '#A988B0',
      --     '#8AA6A2',
      --     '#E8E3E3',
      --   },
      --   brights = {
      --     '#424242',
      --     '#B66467',
      --     '#8C977D',
      --     '#D9BC8C',
      --     '#8DA3B9',
      --     '#A988B0',
      --     '#8AA6A2',
      --     '#E8E3E3',
      --   }
      -- }

      -- Aesthetic Night Colorscheme
      config.bold_brightens_ansi_colors = true
      config.colors = {
        foreground = "#edeff0",
        background = "#0c0e0f",
        cursor_bg = "#edeff0",
        cursor_fg = "#edeff0",
        cursor_border = "#232526",
        selection_fg = "#0c0e0f",
        selection_bg = "#edeff0",
        scrollbar_thumb = "#edeff0",
        split = "#090909",
        ansi = { "#232526", "#df5b61", "#78b892", "#de8f78", "#6791c9", "#bc83e3", "#67afc1", "#e4e6e7" },
        brights = { "#2c2e2f", "#e8646a", "#81c19b", "#e79881", "#709ad2", "#c58cec", "#70b8ca", "#f2f4f5" },
        indexed = { [136] = "#edeff0" },
        tab_bar = {
          active_tab = {
            bg_color = "#0c0e0f",
            fg_color = "#edeff0",
          },
          -- inactive_tab = { bg_color = "#090909", fg_color = "#0c0e0f" },
          -- inactive_tab_hover = { bg_color = "#151515", fg_color = "#090909" },
          inactive_tab = { bg_color = "#090909", fg_color = "#d4d5d6" },
          inactive_tab_hover = { bg_color = "#151515", fg_color = "#e0e2e2" },
          new_tab = { bg_color = "#090909", fg_color = "#d4d5d6" },
          -- new_tab_hover = { bg_color = "#6791c9", fg_color = "#090909" },
          new_tab_hover = { bg_color = "#e0e2e2", fg_color = "#090909" },
        },
      }

      return config
    '';
  };
}
