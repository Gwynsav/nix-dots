# ---------------------------------- #
# -- Lua terminal but not bloated -- #
# ---------------------------------- #

{ colors, ... }:
''
  local tym = require('tym')
  tym.set_config({
    -- Basics
    ---------
    shell        = "hilbish",
    font         = "IBM Plex Mono 10",

    -- Cursor
    ---------
    cursor_shape      = "underline",
    cursor_blink_mode = "on",
    autohide          = true,

    -- Bling
    --------
    padding_horizontal = 32,
    padding_vertical   = 32,

    -- Theming
    ----------
    color_window_background = "${colors.nbg}",
    color_cursor_foreground = "${colors.nbg}",
    color_background        = "${colors.nbg}",
    color_0                 = "${colors.nbg}",
    color_foreground        = "${colors.nfg}",
    color_7                 = "${colors.nfg}",
    color_bold              = "${colors.nfg}",

    color_8                 = "${colors.blk}",
    color_15                = "${colors.gry}",
    color_cursor            = "${colors.wht}",

    color_9                 = "${colors.red}",
    color_1                 = "${colors.red_d}",
    color_10                = "${colors.grn}",
    color_2                 = "${colors.grn_d}",
    color_11                = "${colors.ylw}",
    color_3                 = "${colors.ylw_d}",
    color_12                = "${colors.blu}",
    color_4                 = "${colors.blu_d}",
    color_13                = "${colors.mag}",
    color_5                 = "${colors.mag_d}",
    color_14                = "${colors.cya}",
    color_6                 = "${colors.cya_d}"
  })
''
