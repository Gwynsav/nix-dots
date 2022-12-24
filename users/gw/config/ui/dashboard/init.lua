------------------------------------------
-- best dashboard you'll see in a while --
------------------------------------------
-- ok, maybe not :(

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

local user_panel  = require('ui.dashboard.user_panel')
local calendar    = require('ui.dashboard.calendar')
local date_header = require('ui.dashboard.header_clock')
local notif_log   = require('ui.dashboard.notif_log')
local qk_actions  = require('ui.dashboard.qk_actions')
local sliders     = require('ui.dashboard.sliders')

-- Dashboard
------------
-- The settings for the dashboard itself
local dashboardBox = wibox {
    ontop   = true,
    visible = false,
    -- I do meth
    width   = bar_type == "vertical"   and dash_size * aspect_ratio - (bar_size + beautiful.useless_gap) or dash_size * aspect_ratio,
    height  = bar_type == "horizontal" and dash_size - (bar_size + beautiful.useless_gap) or dash_size,
    shape   = helpers.mkroundedrect(dash_size / 30),
    bg      = beautiful.bg_normal
}

dashboardBox:setup {
    {
        {
            {
                user_panel(),
                {
                    notif_log(),
                    bottom = dash_size / 60,
                    top    = dash_size / 60,
                    widget = wibox.container.margin
                },
                qk_actions(),
                forced_width = dash_size * aspect_ratio * 0.25,
                layout  = wibox.layout.align.vertical
            },
            {
                date_header(),
                spacing = dash_size / 60,
                forced_width = dash_size * aspect_ratio * 0.4,
                layout  = wibox.layout.fixed.vertical
            },
            {
                calendar(),
                sliders(),
                spacing = dash_size / 60,
                forced_width = dash_size * aspect_ratio * 0.25,
                layout  = wibox.layout.fixed.vertical
            },
            spacing = dash_size / 60,
            layout  = wibox.layout.fixed.horizontal
        },
        margins = dash_size / 20,
        widget  = wibox.container.margin
    },
    bg     = beautiful.nbg,
    widget = wibox.container.background
}

-- Signal Connections
---------------------
awesome.connect_signal("widget::dashboard", function()
    dashboardBox.visible = not dashboardBox.visible
    awful.placement.centered(
        dashboardBox,
        {
            left   = bar_size + beautiful.useless_gap,
            parent = awful.screen.focused()
        }
    )
end)
