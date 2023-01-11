----------------------
-- theming settings --
----------------------

-- Imports
----------
local awful     = require('awful')
local gears     = require('gears')
local beautiful = require('beautiful')
local wibox     = require('wibox')
local gc        = gears.color
local gfs       = gears.filesystem

local clrs      = require('themes.palettes.' .. clr_palette)
local asst_dir  = gfs.get_configuration_dir() .. "themes/assets/"
local awes_dir  = gfs.get_themes_dir() .. "default/layouts/"
local defaults  = asst_dir .. "default/"

local theme     = {}
-- Colors
---------
theme.nbg   = clrs.nbg
theme.lbg   = clrs.lbg
theme.blk   = clrs.blk
theme.gry   = clrs.gry
theme.wht   = clrs.wht
theme.dfg   = clrs.dfg
theme.nfg   = clrs.nfg

theme.red   = clrs.red
theme.red_d = clrs.red_d
theme.grn   = clrs.grn
theme.grn_d = clrs.grn_d
theme.ylw   = clrs.ylw
theme.ylw_d = clrs.ylw_d
theme.blu   = clrs.blu
theme.blu_d = clrs.blu_d
theme.mag   = clrs.mag
theme.mag_d = clrs.mag_d
theme.cya   = clrs.cya
theme.cya_d = clrs.cya_d

-- Settings
-----------
-- misc
theme.font                    = ui_font .. "Medium " .. scaling / 108
theme.wallpaper               = user_wall == "default" and clrs.wall   or user_wall
theme.user_avatar             = user_avatar == "default" and defaults .. "user.png" or user_avatar
theme.player_bg               = player_bg == "default" and clrs.player or player_bg
theme.launcher_icon           = gc.recolor_image(asst_dir .. "launcher.svg", theme.dfg)
theme.icon_theme              = "Papirus"

-- Layouts
theme.useless_gap             = scaling / 180
theme.gap_single_client       = true
theme.master_width_factor     = 0.56

-- border settings
theme.border_width            = border_size
theme.border_width_maximized  = theme.border_width
theme.fullscreen_hide_border  = true

-- menu settings
theme.menu_font               = ui_font .. "Bold " .. scaling / 98
theme.menu_height             = scaling / 27
theme.menu_width              = theme.menu_height * 5

-- task/taglist settings
theme.tasklist_plain_task_name   = true
theme.tasklist_disable_icon      = false
theme.tasklist_disable_task_name = true
theme.tasklist_align             = "center"

-- notification settings
theme.notification_padding       = theme.useless_gap * 4
theme.notification_spacing       = theme.notification_padding / 2
theme.notification_accent        = theme.grn

-- Theme Colors
---------------
-- General
theme.bg_normal          = theme.nbg
theme.bg_focus           = theme.lbg
theme.bg_urgent          = theme.blk
theme.fg_normal          = theme.nfg
theme.fg_focus           = theme.nfg
theme.fg_urgent          = theme.red

-- Titlebar
theme.titlebar_font      = ui_font .. "Bold " .. scaling / 108
theme.titlebar_fg_focus  = theme.wht
theme.titlebar_fg_normal = theme.lbg
theme.titlebar_fg_urgent = theme.red_d
theme.titlebar_bg_focus  = theme.dfg
theme.titlebar_bg_normal = theme.bg_urgent
theme.titlebar_bg_urgent = theme.fg_urgent
-- Titlebar Buttons
local button       = asst_dir .. "title_button.svg"
-- close
theme.titlebar_close_button_normal                    = gc.recolor_image(button, theme.titlebar_fg_normal)
theme.titlebar_close_button_normal_hover              = gc.recolor_image(button, theme.titlebar_bg_urgent)
theme.titlebar_close_button_normal_press              = gc.recolor_image(button, theme.titlebar_fg_urgent)
theme.titlebar_close_button_focus                     = gc.recolor_image(button, theme.titlebar_fg_focus)
theme.titlebar_close_button_focus_hover               = theme.titlebar_close_button_normal_press
theme.titlebar_close_button_focus_press               = theme.titlebar_close_button_normal_press
-- maximize
theme.titlebar_maximized_button_normal_inactive       = theme.titlebar_close_button_normal
theme.titlebar_maximized_button_normal_inactive_hover = gc.recolor_image(button, theme.ylw)
theme.titlebar_maximized_button_normal_inactive_press = gc.recolor_image(button, theme.ylw_d)
theme.titlebar_maximized_button_focus_inactive        = theme.titlebar_close_button_focus
theme.titlebar_maximized_button_focus_inactive_hover  = theme.titlebar_maximized_button_normal_inactive_press
theme.titlebar_maximized_button_focus_inactive_press  = theme.titlebar_maximized_button_normal_inactive_press
theme.titlebar_maximized_button_focus_active          = theme.titlebar_maximized_button_normal_inactive_hover
theme.titlebar_maximized_button_focus_active_hover    = theme.titlebar_maximized_button_normal_inactive_press
theme.titlebar_maximized_button_focus_active_press    = theme.titlebar_maximized_button_normal_inactive_press
-- sticky
local sticky      = asst_dir .. "sticky.svg"
theme.titlebar_sticky_button_normal_inactive          = theme.titlebar_close_button_normal
theme.titlebar_sticky_button_normal_inactive_hover    = gc.recolor_image(button, theme.cya)
theme.titlebar_sticky_button_normal_inactive_press    = gc.recolor_image(button, theme.cya_d)
theme.titlebar_sticky_button_focus_inactive           = theme.titlebar_close_button_focus
theme.titlebar_sticky_button_focus_inactive_hover     = theme.titlebar_sticky_button_normal_inactive_press
theme.titlebar_sticky_button_focus_inactive_press     = theme.titlebar_sticky_button_normal_inactive_press
theme.titlebar_sticky_button_focus_active             = theme.titlebar_sticky_button_normal_inactive_hover
theme.titlebar_sticky_button_focus_active_hover       = theme.titlebar_sticky_button_normal_inactive_press
theme.titlebar_sticky_button_focus_active_press       = theme.titlebar_sticky_button_normal_inactive_press

-- Borders
theme.border_color_active     = theme.titlebar_bg_focus
theme.border_color_normal     = theme.titlebar_bg_normal
theme.border_color_urgent     = theme.titlebar_bg_urgent

-- Wibar
theme.wibar_bg                = theme.bg_normal
theme.wibar_fg                = theme.fg_normal

-- Awesome icon
if awm_icon == "default" then
    theme.awesome_icon = require('beautiful.theme_assets').awesome_icon(scaling / 8, theme.fg_normal, theme.bg_normal)
elseif awm_icon == "nix" then
    theme.awesome_icon = gc.recolor_image(asst_dir .. "nix.svg", theme.blu)
else
    theme.awesome_icon = awm_icon
end

-- Taglist
theme.taglist_font            = mn_font .. scaling / 108
theme.taglist_bg_focus        = theme.ylw_d
theme.taglist_bg_occupied     = theme.ylw
theme.taglist_bg_empty        = theme.gry
theme.taglist_bg_urgent       = theme.fg_urgent

-- Tasklist
theme.tasklist_font           = theme.font
theme.tasklist_font_focus     = ui_font .. "Bold " .. scaling / 108
theme.tasklist_bg_normal      = theme.bg_normal
theme.tasklist_bg_focus       = theme.blk
theme.tasklist_bg_urgent      = theme.fg_urgent

-- Layout
theme.layout_tile             = gc.recolor_image(awes_dir .. "tilew.png",       theme.fg_normal)
theme.layout_tileleft         = gc.recolor_image(awes_dir .. "tileleftw.png",   theme.fg_normal)
theme.layout_tilebottom       = gc.recolor_image(awes_dir .. "tilebottomw.png", theme.fg_normal)
theme.layout_tiletop          = gc.recolor_image(awes_dir .. "tiletopw.png",    theme.fg_normal)
theme.layout_fairv            = gc.recolor_image(awes_dir .. "fairvw.png",      theme.fg_normal)
theme.layout_floating         = gc.recolor_image(awes_dir .. "floating.png",    theme.fg_normal)
-- theme.layout_fairh            = gc.recolor_image(awes_dir .. "fairhw.png",      theme.fg_normal)
-- theme.layout_cornernw         = gc.recolor_image(awes_dir .. "cornernww.png",   theme.fg_normal)
-- theme.layout_cornerne         = gc.recolor_image(awes_dir .. "cornernew.png",   theme.fg_normal)
-- theme.layout_cornersw         = gc.recolor_image(awes_dir .. "cornersww.png",   theme.fg_normal)
-- theme.layout_cornerse         = gc.recolor_image(awes_dir .. "cornersew.png",   theme.fg_normal)
theme.mstab_tabbar_style      = "modern"

-- Notification
theme.notification_font         = theme.font

-- Menu
theme.menu_fg_focus           = theme.fg_focus
theme.menu_bg_focus           = theme.bg_focus
theme.menu_fg_normal          = theme.fg_normal
theme.menu_bg_normal          = theme.bg_normal
theme.menu_border_color       = theme.bg_focus
theme.menu_border_width       = theme.border_width
theme.menu_submenu_icon       = gc.recolor_image(asst_dir .. "menu_expand.svg", theme.fg_focus)

-- Tooltip
theme.tooltip_bg              = theme.bg_focus
theme.tooltip_fg              = theme.fg_normal
theme.tooltip_font            = theme.font
theme.tooltip_shape           = gears.shape.rounded_rect

-- Snap
theme.snap_bg                 = theme.taglist_bg_focus
theme.snap_border_width       = titles_size / 2
theme.snap_shape              = gears.shape.rectangle

-- Systray
theme.systray_max_rows        = 1
theme.systray_icon_spacing    = theme.useless_gap / 2

-- Wallpaper setting
--[[ awful.spawn.once("feh --bg-fill --no-xinerama " .. theme.wallpaper) ]]
gears.wallpaper.maximized(theme.wallpaper)

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
