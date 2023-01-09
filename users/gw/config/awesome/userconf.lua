------------------------
-- User Configuration --
------------------------
-- Main user configuration file. Here you may define your default
-- applications, UI scaling, and toggle features on/off.

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

-- Applications
---------------
-- Define your default applications, mainly used in 'config/keys.lua'
terminal     = "alacritty"          or "xterm"
editor       = os.getenv("EDITOR")  or "nvim"
browser      = os.getenv("BROWSER") or "firefox"
top          = "htop"
files_cli    = "lf"
files_gui    = "thunar"
app_launcher = "rofi -show drun"
scrnsht_sel  = "maim -s | xclip -selection clipboard -t image/png"
scrnsht_full = "maim | xclip -selection clipboard -t image/png"

-- Management
-------------
-- 'config/actions/language' uses the 'caps:super' option, you
-- may wanna disable that if you don't use caps as super.
modkey       = "Mod4" -- 4 is super, 1 is alt.
-- Focus mouse hovered clients.
hover_focus  = false

-- UI
-----
-- The 'type' variables can be 'vertical' or 'horizontal'.
-- The 'pos' variables can be 'top', 'bottom', 'right' or 'left'.
-- Please do try to keep this variables coherent (eg, vertical top is incorrect).
-- I recommend keeping every scaling variable in the configuration
-- related to the 'scaling' global variable, it makes managing
-- scaling A LOT easier and significantly less painful.

-- Resolution Scaling (vertical resolution of your monitor)
scaling      = dpi(1080 * 1)
-- Your monitor's aspect ratio, commonly 16:9 or 16:10.
aspect_ratio = dpi(16/9)

-- Bar
bar_size     = scaling / 22.5
bar_type     = "vertical"
bar_pos      = "left"

-- Titles
titles_size  = bar_size * 3/5
titles_type  = "horizontal"
titles_pos   = "top"

-- Notifications
notif_size   = scaling / 14
-- Available positions:
-- top_left       top_right
-- bottom_left bottom_right
notif_pos    = "top_right"

-- Borders (radius is relevant regardless of size)
border_size  = 0 --scaling / 540 -- 2 pixel border on 1080p
border_rad   = scaling / 135

-- Theming
----------
-- Supported themes:
--  'catppuccin', 'tokyonight', 'everforest', 'everblush', 
--  'decay'
-- More themes can be added at 'themes/palettes'.
clr_palette  = "decay"

-- Lua doesn't take '~' for home, use os.getenv('HOME').
-- Your *amazing* profile picture. Either 'default' or path.
user_avatar  = "default"
-- Your wallpaper path. Either 'default' (matches colorscheme) or path.
user_wall    = "default"
-- Music player fallback background. Either 'default' (matches colorscheme) or path.
player_bg    = "default"
-- AwesomeWM icon to be used, either 'default', 'nix' (both follow colorscheme) or path.
awm_icon     = "nix"

-- Fonts to be used. MUST leave a space at the end.
ui_font      = "Roboto "
ic_font      = "Material Icons "
mn_font      = "CaskaydiaCove Nerd Font "

-- Features
-----------
-- These options mainly serve the purpose of toggling features.

-- Changes default state of the bar. Can still be brought up
-- by emitting the 'widget::bar' signal (mod + b) even if disabled.
bar_enabled  = true
-- Enables/disables battery metrics.
battery      = false
-- Enables/disables brightness metrics.
brightness   = false
-- Enables/disables bluetooth status.
bluetoothctl = false

-- Autostart
------------
awful.spawn.once("picom")
awful.spawn.once("mpd")
awful.spawn.once("mpDris2")
