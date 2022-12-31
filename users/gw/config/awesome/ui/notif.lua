--------------------------------
-- notification configuration --
--------------------------------

-- Imports
----------
local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local ruled     = require('ruled')
local naughty   = require('naughty')
local beautiful = require('beautiful')
local gfs       = gears.filesystem

local close_ico = gfs.get_configuration_dir() .. "themes/assets/close.svg"

local helpers   = require('helpers')
local rubato    = require('modules.rubato')

-- Notifications
----------------
ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            ontop            = true,
            implicit_timeout = 6,
            border_width     = 0,
            position         = notif_pos,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    -- Animation stolen right off the certified animation lady.
    local x = wibox.widget { 
        widget = wibox.widget.imagebox,
        image  = gears.color.recolor_image(close_ico, beautiful.red),
    }
    local timeout_graph = wibox.widget {
        widget    = wibox.container.arcchart,
        min_value = 0,
        max_value = 100,
        value     = 0,
        thickness = notif_size / 20,
        paddings  = notif_size / 20,
        rounded_edge = true,
        colors       = { beautiful.red },
        bg           = beautiful.lbg,
        x,
    }
    local title = wibox.widget {
        widget        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.
                        waiting_nonlinear_back_and_forth,
        speed         = 100,
        rate          = 144,
        {
            widget = wibox.widget.textbox,
            font   = ui_font .. notif_size / 3,
            text   = n.title
        }
    }
    local summary = wibox.widget {
        widget        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.
                        waiting_nonlinear_back_and_forth,
        speed         = 100,
        rate          = 144,
        {
            widget = wibox.widget.textbox,
            font   = ui_font .. notif_size / 3.33,
            text   = gears.string.xml_unescape(n.message)
        }
    }
    local image = wibox.widget {
        {
            widget = wibox.widget.imagebox,
            image  = n.image,
            resize = true,
            halign = "center",
            valign = "center",
            clip_shape    = helpers.mkroundedrect(),
            forced_height = notif_size * 2/3
        },
        right  = notif_size / 4,
        widget = wibox.container.margin
	  }
    naughty.layout.box { 
        notification = n, 
        cursor       = "hand2",
        shape        = helpers.mkroundedrect(),
        widget_template = {
            {
                -- Title config
                {
                    {
                        {
                            {
                                {
                                    {
                                        title,
                                        halign = "left",
                                        layout = wibox.container.place
                                    },
                                    {
                                        {
                                            timeout_graph,
                                            left    = notif_size / 5,
                                            bottom  = notif_size / 5,
                                            top     = notif_size / 5,
                                            widget  = wibox.container.margin
                                        },
                                        halign = "right",
                                        layout = wibox.container.place
                                    },
                                    fill_space = true,
                                    layout = wibox.layout.align.horizontal
                                },
                                left   = notif_size / 3,
                                right  = notif_size / 3,
                                widget = wibox.container.margin
                            },
                            forced_height = notif_size,
                            bg     = beautiful.lbg,
                            widget = wibox.container.background
                        },
                        strategy = "min",
                        width    = notif_size * 4,
                        widget   = wibox.container.constraint
                    },
                    strategy = "max",
                    width    = notif_size * 8,
                    widget   = wibox.container.constraint
                },
                -- Content config
                {
                    {
                        {
                            {
                                image,
                                summary,
                                layout = wibox.layout.fixed.horizontal
                            },
                            margins = notif_size / 4,
                            widget  = wibox.container.margin
                        },
                        strategy = "min",
                        height   = notif_size * 2,
                        widget   = wibox.container.constraint
                    },
                    strategy = "max",
                    width    = notif_size * 8,
                    widget   = wibox.container.constraint
                },
                layout = wibox.layout.align.vertical
            },
            id     = "background_role",
            bg     = beautiful.nbg,
            widget = naughty.container.background
        }
    }
    local anim = rubato.timed {
        intro      = 0,
        duration   = n.timeout,
        subscribed = function(pos)
            timeout_graph.value = pos
        end
    }
    anim.target = 100
end)
