-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Titlebars
------------
-- Add a titlebar if titlebars_enabled is set to true in the rules.
local def_button  = titles_size / 4
local button_size = def_button - beautiful.border_width
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({ }, 1, function()
            c:activate { context = "titlebar", action = "mouse_move"  }
        end),
        awful.button({ }, 3, function()
            c:activate { context = "titlebar", action = "mouse_resize"}
        end),
    }

    local right_titlebar = awful.titlebar(c, {
            size        = titles_size,
            position    = titles_pos,
        })
    right_titlebar.widget = {
        { -- Left
            {
                {
                    {
                        awful.titlebar.widget.closebutton(c),
                        shape  = helpers.mkroundedrect(),
                        widget = wibox.container.widget
                    },
                    direction = "east",
                    widget    = wibox.container.rotate
                },
                left  = def_button, 
                right = button_size, 
                top   = button_size,
                widget  = wibox.container.margin
            },
            {
                {
                    {
                        awful.titlebar.widget.maximizedbutton(c),
                        shape  = helpers.mkroundedrect(),
                        widget = wibox.container.widget
                    },
                    direction = "east",
                    widget    = wibox.container.rotate
                },
                left  = button_size, 
                right = button_size, 
                top   = button_size,
                widget  = wibox.container.margin
            },
            {
                {
                    {
                        awful.titlebar.widget.stickybutton(c),
                        -- awful.titlebar.widget.ontopbutton(c),
                        shape  = helpers.mkroundedrect(),
                        widget = wibox.container.widget
                    },
                    direction = "east",
                    widget    = wibox.container.rotate
                },
                left  = button_size, 
                right = button_size, 
                top   = button_size,
                widget  = wibox.container.margin
            },
            layout      = wibox.layout.fixed.vertical
        },
        { -- Middle
            buttons     = buttons,
            layout      = wibox.layout.flex.vertical
        },
        { -- Right
             --[[ { -- Title ]]
             --[[     { ]]
             --[[         {  ]]
             --[[             halign = "end", ]]
             --[[             widget = awful.titlebar.widget.titlewidget(c) ]]
             --[[         }, ]]
             --[[         direction = titles_pos == "left" and "east" or "west", ]]
             --[[         widget    = wibox.container.rotate ]]
             --[[     }, ]]
             --[[     right  = def_button,   ]]
             --[[     left   = button_size, ]]
             --[[     bottom = button_size, ]]
             --[[     widget  = wibox.container.margin ]]
             --[[ }, ]]
            buttons     = buttons,
            layout      = wibox.layout.fixed.vertical
        },
        layout = wibox.layout.align.vertical
    }
end)
