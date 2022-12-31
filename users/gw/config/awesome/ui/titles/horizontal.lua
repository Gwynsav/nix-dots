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

    local top_titlebar = awful.titlebar(c, {
            size        = titles_size,
            position    = titles_pos,
        })
    top_titlebar.widget = {
        { -- Left
            --[[ { -- Title ]]
            --[[     {  ]]
            --[[         widget = awful.titlebar.widget.titlewidget(c), ]]
            --[[         halign = "start" ]]
            --[[     }, ]]
            --[[     left   = def_button * 2, ]]
            --[[     top    = button_size,  ]]
            --[[     bottom = button_size, ]]
            --[[     widget  = wibox.container.margin ]]
            --[[ }, ]]
            buttons     = buttons,
            layout      = wibox.layout.fixed.horizontal
        },
        { -- Middle
            buttons     = buttons,
            layout      = wibox.layout.flex.horizontal
        },
        { -- Right
            {
                {
                    awful.titlebar.widget.stickybutton(c),
                    -- awful.titlebar.widget.ontopbutton(c),
                    shape  = helpers.mkroundedrect(),
                    widget = wibox.container.background
                },
                right  = button_size, 
                bottom = button_size, 
                top    = button_size,
                widget  = wibox.container.margin
            },
            {
                {
                    awful.titlebar.widget.maximizedbutton(c),
                    shape  = helpers.mkroundedrect(),
                    widget = wibox.container.background
                },
                right  = button_size, 
                bottom = button_size, 
                top    = button_size,
                widget  = wibox.container.margin
            },
            {
                {
                    awful.titlebar.widget.closebutton(c),
                    shape  = helpers.mkroundedrect(),
                    widget = wibox.container.background
                },
                right  = def_button * 2, 
                bottom = button_size,
                top    = button_size, 
                widget  = wibox.container.margin
            },
            layout      = wibox.layout.fixed.horizontal
        },
        layout = wibox.layout.align.horizontal
    }
end)
