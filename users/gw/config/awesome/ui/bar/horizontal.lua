----------------------------------
-- horizontal bar configuration --
----------------------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local helpers   = require('helpers')
local gettags   = require('ui.bar.stuff.tags')
local gettasks  = require('ui.bar.stuff.tasks')
local getlayout = require('ui.bar.stuff.layout')

-- Bar Widgets
--------------
-- Awesome launcher button
bar_dash = wibox.widget { 
    {
        {
            image      = beautiful.awesome_icon,
            clip_shape = helpers.mkroundedrect(), 
            widget     = wibox.widget.imagebox 
        },
        margins = bar_size / 7,
        widget  = wibox.container.margin
    },
    bg     = beautiful.lbg,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background,
    buttons = {
        awful.button({}, 1, function()
            awesome.emit_signal('widget::dashboard')
        end)
    },
}
helpers.add_hover(bar_dash, beautiful.lbg, beautiful.blk)

-- Status icons
local function status_widget()
    return wibox.widget {
        font   = ic_font .. bar_size / 3.25,
        valign = "center",
        halign = "center",
        widget = wibox.widget.textbox,
        buttons = {
            awful.button({}, 1, function()
                awful.spawn(button) end)
        }
    }
end

-- Battery bar
bar_battery_prog = wibox.widget {
    max_value        = 100,
    forced_width     = (bar_size * 5/4) * aspect_ratio,
    clip             = true,
    shape            = helpers.mkroundedrect(),
    bar_shape        = helpers.mkroundedrect(),
    background_color = beautiful.bg_focus,
    color            = beautiful.grn,
    widget           = wibox.widget.progressbar
}
bar_battery_text     = status_widget()

-- I don't want to call this a systray... but
bar_sound     = status_widget("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") -- Sound muted?
bar_btn_sound = helpers.mkbtn(bar_sound,     beautiful.nbg, beautiful.lbg)
bar_network   = status_widget() -- Network status?
bar_btn_net   = helpers.mkbtn(bar_network,   beautiful.nbg, beautiful.lbg)
bar_bluetooth = status_widget("bluetoothctl power off") -- Bluetooth on?
bar_btn_blue  = helpers.mkbtn(bar_bluetooth, beautiful.nbg, beautiful.lbg)

-- Create a textclock widget
bar_clock = {
    {
        {
            {
                format = '<b>%I:%M</b>',
                font   = mn_font .. bar_size / 4,
                valign = "center",
                widget = wibox.widget.textclock
            },
            left    = bar_size / 4, 
            right   = bar_size / 4,
            widget  = wibox.container.margin
        },
        bg     = beautiful.titlebar_fg_normal,
        shape  = helpers.mkroundedrect(),
        widget = wibox.container.background
    },
    margins = bar_size / 7,
    widget  = wibox.container.margin
}

-- Awesome Bar
--------------
-- The actual bar itself
screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8" }, s, awful.layout.layouts[1])
    s.mywibox = awful.wibar {
        visible  = bar_enabled,
        position = bar_pos,
        screen   = s,
        height   = bar_size,
        -- 1.77 represents a 16:9 aspect ratio. 4:3, for reference, is 1.33.
        width    = scaling * 1.77 - beautiful.useless_gap * 3,
        shape    = helpers.mkroundedrect(),
        margins  = {
            top = beautiful.useless_gap,
        },
        widget   = {
            { -- Top Widgets
                {
                    bar_dash,
                    left    = bar_size / 4,
                    top     = bar_size / 8,
                    bottom  = bar_size / 8,
                    widget = wibox.container.margin
                },
                {
                    {
                        {
                            {
                                gettags(s),
                                direction = "east",
                                widget    = wibox.container.rotate
                            },
                            left   = bar_size / 3,
                            top    = bar_size / 4.5,
                            bottom = bar_size / 4.5,
                            right  = bar_size / 3,
                            widget = wibox.container.margin
                        },
                        shape   = helpers.mkroundedrect(),
                        bg      = beautiful.lbg,
                        widget  = wibox.container.background
                    },
                    margins = bar_size / 5,
                    widget  = wibox.container.margin
                },
                layout = wibox.layout.fixed.horizontal,
            },
            { -- Middle Widgets
                {
                    gettasks(s),
                    margins = bar_size / 8,
                    widget  = wibox.container.margin
                },
                valign = "center",
                widget = wibox.container.place
            },
            { -- Bottom Widgets
                {
                    {
                        bar_battery_prog,
                        {
                            bar_battery_text,
                            fg     = beautiful.bg_normal,
                            widget = wibox.container.background
                        },
                        layout = wibox.layout.stack
                    },
                    margins = {
                        top    = bar_size / 6,
                        bottom = bar_size / 6,
                        --[[ top    = bar_size / 4 ]]
                    },
                    visible = battery,
                    widget  = wibox.container.margin
                },
                {
                    bar_clock,
                    right  = bar_size / 20,
                    widget = wibox.container.margin
                },
                {
                    {
                        {
                            bar_btn_sound,
                            {
                                bar_btn_blue,
                                visible = bluetoothctl,
                                layout  = wibox.layout.fixed.horizontal
                            },
                            bar_btn_net,
                            {
                                getlayout(s),
                                margins = bar_size / 6,
                                widget  = wibox.container.margin
                            },
                            layout  = wibox.layout.fixed.horizontal
                        },
                        top    = bar_size / 8,
                        bottom = bar_size / 8,
                        right  = bar_size / 4,
                        widget = wibox.container.margin
                    },
                    layout  = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.fixed.horizontal,
            },
            layout = wibox.layout.align.horizontal
        },
    }
end)

-- Bar Gaps to Edge
-------------------
local screen = awful.screen.focused()
if bar_pos == "bottom" then
    screen.mywibox.margins = {
        bottom = beautiful.useless_gap
    }
else
    screen.mywibox.margins = {
        top    = beautiful.useless_gap
    }
end

-- Signal Connections
---------------------
-- Toggle bar
awesome.connect_signal("widget::bar", function()
    local s = awful.screen.focused()
    s.mywibox.visible = not s.mywibox.visible
end)

-- Battery signal
awesome.connect_signal("signal::battery", function(level, charging)
    bar_battery_prog.value  = level
    if charging then
        bar_battery_text.text = ""
        bar_battery_text.font = ic_font .. bar_size / 3
    else
        bar_battery_text.text = level
        bar_battery_text.font = ui_font .. "Bold " .. bar_size / 3.33
    end
end)

-- Sound signal
awesome.connect_signal("signal::volume", function(volume, muted)
    if muted then
        bar_sound.text    = ""
        bar_btn_sound.visible = true
    else
        bar_btn_sound.visible = false
    end
end)
-- Networking signals
if bluetoothctl then
    awesome.connect_signal("signal::bluetooth", function(is_enabled)
        if is_enabled then
            bar_bluetooth.text   = ""
            bar_btn_blue.visible = true
        else
            bar_btn_blue.visible = false
        end
    end)
end
awesome.connect_signal("signal::network", function(is_enabled)
    bar_network.text   = is_enabled and "" or ""
end)
