# ---------------------------------- #
# -- Lua terminal but not bloated -- #
# ---------------------------------- #

{ colors, ... }:
with colors; ''
  local tym = require('tym')
  tym.set_config({
    -- Basics
    ---------
    shell        = "hilbish",
    font         = "Fira Code 10",

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
    color_window_background = "${nbg}",
    color_cursor_foreground = "${nbg}",
    color_background        = "${nbg}",
    color_0                 = "${nbg}",
    color_foreground        = "${nfg}",
    color_7                 = "${nfg}",
    color_bold              = "${nfg}",

    color_8                 = "${blk}",
    color_15                = "${gry}",
    color_cursor            = "${wht}",

    color_9                 = "${red}",
    color_1                 = "${red_d}",
    color_10                = "${grn}",
    color_2                 = "${grn_d}",
    color_11                = "${ylw}",
    color_3                 = "${ylw_d}",
    color_12                = "${blu}",
    color_4                 = "${blu_d}",
    color_13                = "${mag}",
    color_5                 = "${mag_d}",
    color_14                = "${cya}",
    color_6                 = "${cya_d}"
  })
''
