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

naughty.connect_signal("request::icon", function(n, context, hints)
    if context ~= "app_icon" then
        return
    end
    local path = require('menubar').utils.lookup_icon(hints.app_icon) or
                 require('menubar').utils.lookup_icon(hints.app_icon:lower())
    if path then
        n.icon = path
    end
end)
naughty.connect_signal("request::action_icon", function(a, context, hints)
    a.icon = menubar.utils.lookup_icon(hints.id)
end)

naughty.connect_signal("request::display", function(n)
    local title = wibox.widget {
        widget        = wibox.container.scroll.horizontal,
        step_function = wibox.container.scroll.step_functions.
                        waiting_nonlinear_back_and_forth,
        speed         = 100,
        rate          = 144,
        {
            widget = wibox.widget.textbox,
            halign = "center",
            font   = ui_font .. notif_size / 7,
            markup = "<b>" .. n.title .. "</b>"
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
            halign = "center",
            font   = ui_font .. notif_size / 8,
            text   = gears.string.xml_unescape(n.message)
        }
    }
    local image = wibox.widget {
        widget = wibox.widget.imagebox,
        image  = n.icon,
        resize = true,
        align  = "center",
        clip_shape    = helpers.mkroundedrect(),
	  }
    -- Animation stolen right off the certified animation lady.
    local timeout_graph = wibox.widget {
        widget    = wibox.container.arcchart,
        min_value = 0,
        max_value = 100,
        value     = 0,
        thickness = notif_size / 24,
        paddings  = notif_size / 24,
        rounded_edge = true,
        colors       = { beautiful.notification_accent },
        bg           = beautiful.lbg,
        forced_height = notif_size * 3/4,
        forced_width  = notif_size * 3/4,
        image,
    }
    local widget = naughty.layout.box { 
        notification = n, 
        cursor       = "hand2",
        shape        = helpers.mkroundedrect(),
        widget_template = {
            {
                {
                    {
                        {
                            timeout_graph,
                            margins = notif_size / 10,
                            widget  = wibox.container.margin
                        },
                        strategy = "min",
                        width    = notif_size / 3,
                        widget   = wibox.container.constraint
                    },
                    strategy = "max",
                    width    = notif_size * 1.5,
                    widget   = wibox.container.constraint
                },
                {
                    {
                        {
                            {
                                {
                                    {
                                        {
                                            title,
                                            halign = "center",
                                            widget = wibox.container.place
                                        },
                                        {
                                            summary,
                                            halign = "center",
                                            widget = wibox.container.place
                                        },
                                        spacing = notif_size / 24,
                                        layout  = wibox.layout.fixed.vertical
                                    },
                                    align  = "center",
                                    widget = wibox.container.place
                                },
                                margins = notif_size / 4,
                                widget  = wibox.container.margin
                            },
                            bg     = beautiful.lbg,
                            shape  = helpers.mkroundedrect(),
                            widget = wibox.container.background
                        },
                        strategy = "min",
                        width    = notif_size * 1.5,
                        widget   = wibox.container.constraint
                    },
                    strategy = "max",
                    width   = notif_size * 3,
                    height  = notif_size,
                    widget  = wibox.container.constraint
                },
                layout = wibox.layout.fixed.horizontal
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
    anim.target     = 100
end)
