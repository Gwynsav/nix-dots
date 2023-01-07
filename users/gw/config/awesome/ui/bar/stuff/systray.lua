--------------------
-- simple systray --
--------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local wibox     = require('wibox')

local helpers   = require('helpers')

-- Systray
----------
local systray_size = bar_size * 2
local systrayBox = awful.popup {
    ontop   = true,
    visible = false,
    width   = systray_size,
    height  = systray_size,
    shape   = helpers.mkroundedrect(),
    bg      = beautiful.bg_normal,
    border_width = border_size,
    border_color = beautiful.bg_focus,
    widget  = {
        {
            horizontal  = false,
            base_size   = systray_size / 4,
            widget      = wibox.widget.systray
        },
        margins = beautiful.useless_gap,
        widget  = wibox.container.margin
    }
}

-- Visibility
-------------
awesome.connect_signal("widget::systray", function()
    systrayBox.visible = not systrayBox.visible
    if bar_pos == "left" then
        awful.placement.bottom_left(
            systrayBox,
            {
                margins = {
                    bottom = systray_size * 7/4 + beautiful.useless_gap * 2,
                    left   = bar_size + beautiful.useless_gap * 2
                },
                parent  = awful.screen.focused()
            }
        )
    elseif bar_pos == "right" then
        awful.placement.bottom_right(
            systrayBox,
            {
                margins = {
                    bottom = systray_size * 7/4 + beautiful.useless_gap * 2,
                    right  = bar_size + beautiful.useless_gap * 2
                },
                parent  = awful.screen.focused()
            }
        )
    elseif bar_pos == "bottom" then
        awful.placement.bottom_right(
            systrayBox,
            {
                margins = {
                    bottom = bar_size + beautiful.useless_gap * 2,
                    right  = systray_size * 7/4 + beautiful.useless_gap * 2 
                },
                parent  = awful.screen.focused()
            }
        )
    elseif bar_pos == "top" then
        awful.placement.top_right(
            systrayBox,
            {
                margins = {
                    top    = bar_size + beautiful.useless_gap * 2,
                    right  = systray_size * 7/4 + beautiful.useless_gap * 2 
                },
                parent  = awful.screen.focused()
            }
        )
    end
end)
