--------------------------
-- unoriginal dashboard --
--------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

dash_size         = scaling - bar_size - 3 * beautiful.useless_gap

local user_panel  = require('ui.dashboard.user_panel')
local qk_actions  = require('ui.dashboard.qk_actions')
local music       = require('ui.dashboard.music')
local sliders     = require('ui.dashboard.sliders')
local calendar    = require('ui.dashboard.calendar')

-- Dashboard
------------
-- The settings for the dashboard itself
local dashboardBox = wibox {
    ontop   = true,
    visible = false,
    width   = dash_size * 0.4,
    height  = dash_size,
    x       = bar_type == "vertical" and bar_size + 2 * beautiful.useless_gap or beautiful.useless_gap,
    y       = bar_type == "vertical" and bar_size / 2 + 2 * beautiful.useless_gap or bar_size + 2 * beautiful.useless_gap,
    shape   = helpers.mkroundedrect(),
    bg      = beautiful.bg_normal
}

dashboardBox:setup {
    {
        {
            user_panel(),
            qk_actions(),
            music(),
            spacing = dash_size / 80,
            layout  = wibox.layout.fixed.vertical
        },
        margins = dash_size / 40,
        widget  = wibox.container.margin
    },
    bg     = beautiful.nbg,
    widget = wibox.container.background
}

-- Signal Connections
---------------------
awesome.connect_signal("widget::dashboard", function()
    dashboardBox.visible = not dashboardBox.visible
end)
