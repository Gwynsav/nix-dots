------------------------
-- User Configuration --
------------------------
-- Main user configuration file. Here you may define your default
-- applications, UI scaling, and toggle features on/off.

-- Imports
----------
local beautiful = require('beautiful')
local defaults  = require('gears.filesystem').get_configuration_dir() .. "themes/assets/default/"
local dpi       = beautiful.xresources.apply_dpi

-- Applications
---------------
-- Define your default applications, mainly used in 'config/keys.lua'
terminal     = "alacritty"
editor       = os.getenv("EDITOR")  or "nvim"
browser      = os.getenv("BROWSER") or "firefox"
top          = "htop"
files_cli    = "lf"
files_gui    = "thunar"
app_launcher = "rofi -show drun"

-- UI
-----
-- The 'type' variables can be 'vertical' or 'horizontal'.
-- The 'pos' variables can be 'top', 'bottom', 'right' or 'left'.
-- Please do try to keep this variables coherent.
-- I recommend keeping every scaling variable in the configuration
-- related to the 'scaling' global variable, it makes managing
-- scaling A LOT easier and significantly less painful.

-- Resolution Scaling (vertical resolution of your monitor)
scaling      = dpi(1080 * 1)
aspect_ratio = dpi(16/9)

-- Bar
bar_size     = scaling / 22.5
bar_type     = "vertical"
bar_pos      = "left"

-- Titles
titles_size  = bar_size / 2
titles_type  = "horizontal"
titles_pos   = "top"

-- Notifications
notif_size   = scaling / 32 
-- Available positions:
-- top_left       top_right
-- bottom_left bottom_right
notif_pos    = "top_right"

-- Border Radius
border_rad   = scaling / 135

-- Theming
----------
-- Supported themes:
--  'catppuccin', 'tokyonight', 'everforest', 'articblush',
--  'everblush', 'decay'

-- More themes can be added at 'themes/palettes'.
clr_palette  = "decay"

-- Lua doesn't take '~' for home, use os.getenv('HOME').
-- Your *amazing* profile picture.
user_avatar  = defaults .. "user.png"
-- Your wallpaper path.
user_wall    = defaults .. "wall.png"

-- Fonts to be used. MUST leave a space at the end.
ui_font      = "Noto Sans "
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
-- It's recommended that you set your autostart applications at the
-- designated location in 'rc.lua' since at that point in the
-- configuration loading, every variable is defined and can be
-- used for, for example, changing wallpapers to 'beautiful.wallpaper'.
