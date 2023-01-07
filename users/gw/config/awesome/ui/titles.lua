------------------------
-- Client Decorations --
------------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

-- Titlebars
------------
-- Add a titlebar if titlebars_enabled is set to true in the rules.
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

    local n_titlebar = awful.titlebar(c, {
            size        = titles_size,
            position    = titles_pos,
        })
    n_titlebar.widget = {
        {
            { -- Left
                awful.titlebar.widget.closebutton(c),
                awful.titlebar.widget.maximizedbutton(c),
                awful.titlebar.widget.stickybutton(c),
                -- awful.titlebar.widget.ontopbutton(c),
                spacing = titles_size / 8,
                layout  = titles_type == "horizontal" and wibox.layout.fixed.horizontal or wibox.layout.fixed.vertical
            },
            { -- Middle
                buttons = buttons,
                layout  = titles_type == "horizontal" and wibox.layout.fixed.horizontal or wibox.layout.fixed.vertical
            },
            { -- Right
                titles_type == "horizontal" and awful.titlebar.widget.titlewidget(c),
                buttons = buttons,
                layout  = titles_type == "horizontal" and wibox.layout.fixed.horizontal or wibox.layout.fixed.vertical
            },
            layout  = titles_type == "horizontal" and wibox.layout.align.horizontal or wibox.layout.align.vertical
        },
        top     = titles_type == "horizontal" and titles_size / 5 or titles_size / 4,
        bottom  = titles_type == "horizontal" and titles_size / 5 or titles_size / 2,
        left    = titles_type == "horizontal" and titles_size / 4 or titles_size / 5,
        right   = titles_type == "horizontal" and titles_size / 2 or titles_size / 5,
        widget  = wibox.container.margin
    }
end)
