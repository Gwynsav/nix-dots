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
dash_width        = dash_size * 0.5

local user_panel  = require('ui.dashboard.modules.user_panel')
local qk_actions  = require('ui.dashboard.modules.qk_actions')
local music       = require('ui.dashboard.modules.music')
local sliders     = require('ui.dashboard.modules.sliders')
local calendar    = require('ui.dashboard.modules.calendar')

-- Dashboard
------------
-- The settings for the dashboard itself
local dashboardBox = wibox {
    ontop   = true,
    visible = false,
    width   = dpi(dash_width * 0.925),
    height  = dpi(dash_size * 0.83),
    shape   = helpers.mkroundedrect(),
    bg      = beautiful.bg_normal
}

local header = wibox.widget {
    {
        id     = 'text_role',
        markup = "<b>System Panel</b>",
        font   = ui_font .. dash_size / 70,
        widget = wibox.widget.textbox
    },
    fg     = beautiful.gry,
    widget = wibox.container.background,
    set_markup = function(self, content)
        self:get_children_by_id('text_role')[1].markup = content
    end
}
awful.spawn.easy_async_with_shell(
    "uname -n", function(stdout)
        hostname      = stdout:match('(%w+)')
        header.markup = "<b>System Panel</b> • " .. hostname
    end
)

dashboardBox:setup {
    {
        {
            {
                header,
                user_panel(),
                music(),
                calendar(),
                qk_actions(),
                spacing = dpi(dash_size / 80),
                layout  = wibox.layout.fixed.vertical
            },
            strategy = "exact",
            width    = dpi(dash_width * 0.7),
            widget   = wibox.container.constraint
        },
        nil,
        {
            sliders(),
            strategy = "exact",
            width    = dpi(dash_width * 0.1),
            widget   = wibox.container.constraint
        },
        layout = wibox.layout.align.horizontal
    },
    margins = dpi(dash_size / 40),
    widget  = wibox.container.margin
}

-- Signal Connections
---------------------
awesome.connect_signal("widget::dashboard", function()
    dashboardBox.visible = not dashboardBox.visible
    awful.placement.next_to(
        dashboardBox,
        {
            preferred_positions = bar_pos == "left" and "right" or
                                  bar_pos == "right" and "left" or
                                  bar_pos == "top" and "bottom" or
                                  bar_pos == "bottom" and "top",
            preferred_anchors   = "front",
            margins             = dpi(beautiful.useless_gap * 2),
            geometry            = awful.screen.focused().mywibox
        }
    )
end)
