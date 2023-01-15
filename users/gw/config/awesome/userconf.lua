------------------------
-- User Configuration --
------------------------
-- Main user configuration file. Here you may define your default
-- applications, UI scaling, and toggle features on/off.

-- Imports
----------
local awful     = require('awful')
local dpi       = require('beautiful').xresources.apply_dpi

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

-- Global Variables
-------------------
-- 'config/actions/language' uses the 'caps:super' option, you
-- may wanna disable that if you don't use caps as super.
modkey       = "Mod4" -- 4 is super, 1 is alt.
-- Focus mouse hovered clients.
hover_focus  = false
-- Enables/disables battery metrics.
battery      = false
-- Enables/disables brightness metrics.
brightness   = false
-- Enables/disables bluetooth status.
bluetoothctl = false

-- Settings
-----------
local user = {}

-- UI
-----
-- Resolution Scaling (vertical resolution of your monitor)
scaling      = 1080
-- Your monitor's aspect ratio, commonly 16:9 or 16:10.
aspect_ratio = 16/9

--- Bar
-- Changes default state of the bar. Can still be brought up
-- by emitting the 'widget::bar' signal (mod + b) even if disabled.
bar_enabled  = true
bar_size     = scaling * 0.045
-- Can be 'top', 'bottom', 'right' or 'left'.
bar_pos      = "top"
-- Adds 'outer_gaps' to the bar.
bar_gap      = false

--- Titles
-- Toggles titlebars
title_enable = true
titles_size  = bar_size * 0.6
-- Can be 'top', 'bottom', 'right' or 'left'.
titles_pos   = "top"

--- Notifications
notif_size   = scaling * 0.09
-- Available positions:
-- Can be 'top_left', 'top_right', 'bottom_left' or 'bottom_right'.
notif_pos    = "top_right"

-- Gap configuration. 
--   Inner gaps are common gaps. 
--   Outer gaps are the gaps between the tag contents and the edge of the screen.
inner_gaps   = scaling / 270
outer_gaps   = inner_gaps * 3 -- Triple outer gap.

-- Borders (radius is relevant regardless of size)
user.border_size  = 0 --scaling / 540 -- 2 pixel border on 1080p
user.border_rad   = scaling * 0.008

-- Theming
----------
-- Supported themes:
--  'catppuccin', 'tokyonight', 'everforest', 'everblush', 
--  'decay'
-- More themes can be added at 'themes/palettes'.
user.clr_palette  = "catppuccin"

-- Fonts to be used. MUST leave a space at the end.
ui_font      = "Roboto "
ic_font      = "Material Icons "
mn_font      = "CaskaydiaCove Nerd Font "

-- Lua doesn't take '~' for home, use os.getenv('HOME').
-- Your *amazing* profile picture. Either 'default' or path.
user_avatar  = "default"
-- Your wallpaper path. Either 'default' (matches colorscheme) or path.
user_wall    = "default"
-- Music player fallback background. Either 'default' (matches colorscheme) or path.
player_bg    = "default"
-- AwesomeWM icon to be used, either 'default', 'nix' (both follow colorscheme) or path.
awm_icon     = "default"

-- Miscelaneous
---------------
-- Directory to save screenshots to (when prompted to do so).
user.scrnshot_dir = os.getenv("HOME") .. "/Pictures/"

-- Autostart
------------
awful.spawn.once("picom")
awful.spawn.once("mpd")
awful.spawn.once("mpDris2")

-------------------------------
-- End Of User Configuration --
-------------------------------
-- The following code just handles some of the previouly set variables for convenience.

-- Adjustments
--------------
-- Determine bar type.
if bar_pos == "left" or bar_pos == "bottom" then
    bar_type = "vertical"
else
    bar_type = "horizontal"
end
-- If titlebars are enabled, determine their type.
if title_enable then
    if titles_pos == "left" or titles_pos == "right" then
        titles_type = "vertical"
    else
        titles_type = "horizontal"
    end
end

return user
