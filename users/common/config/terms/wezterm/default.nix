{ colors, ... }:

with colors; {
  programs.wezterm = {
    enable       = true;
    colorSchemes = import ./colors.nix { inherit colors; };
    extraConfig  = ''
      local wez = require('wezterm')
      return {

        default_prog     = { 'hilbish' },
        
        -- Performance
        --------------
        front_end        = "OpenGL",
        enable_wayland   = false,
        scrollback_lines = 1024,

        -- Fonts
        --------
        font         = wez.font_with_fallback({ 
          "Fira Code",
          "CaskaydiaCove Nerd Font",
          "Material Icons",
          "Blobmoji"
        }),
        font_rules    = {
          {
            italic = true,
            font   = wez.font("CaskaydiaCove Nerd Font", { italic = true })
          }
        },
        font_size         = 10.0,
        line_height       = 1.0,
        harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' },

        -- Bling
        --------
        color_scheme   = "followSystem",
        window_padding = {
          left = "32pt", right = "32pt",
          bottom = "32pt", top = "32pt"
        },
        default_cursor_style = "SteadyUnderline",
        enable_scroll_bar    = false,

        -- Tabbar
        ---------
        enable_tab_bar               = true,
        use_fancy_tab_bar            = false,
        hide_tab_bar_if_only_one_tab = true,
        show_tab_index_in_tab_bar    = false,

        -- Miscelaneous
        ---------------
        window_close_confirmation = "NeverPrompt",
        inactive_pane_hsb         = { 
          saturation = 1.0, brightness = 0.8
        },
        check_for_updates = false,
      }
    '';
  };
}
