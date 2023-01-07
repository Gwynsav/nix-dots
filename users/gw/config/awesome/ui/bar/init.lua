-----------------------
-- bar configuration --
-----------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local helpers   = require('helpers')
local gettags   = require('ui.bar.stuff.tags')
local gettasks  = require('ui.bar.stuff.tasks')
local getlayout = require('ui.bar.stuff.layout')
require('ui.bar.stuff.systray')

-- Bar Widgets
--------------
-- Awesome launcher button
local bar_dash = wibox.widget { 
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

-- Application Launcher
local bar_launcher = {
    {
        {
            image       = beautiful.launcher_icon,
            clip_shape  = helpers.mkroundedrect(),
            widget      = wibox.widget.imagebox
        },
        margins = bar_size / 7,
        widget  = wibox.container.margin
    },
    bg      = beautiful.lbg,
    shape   = helpers.mkroundedrect(),
    widget  = wibox.container.background,
    buttons = {
        awful.button({}, 1, function()
            awful.spawn(app_launcher)
        end)
    }
}
--[[ helpers.add_hover(bar_launcher, beautiful.lbg, beautiful.blk) ]]

-- Status icons
local function status_widget(button)
    return wibox.widget {
        font    = ic_font .. bar_size / 3,
        align   = "center",
        widget  = wibox.widget.textbox,
        buttons = {
            awful.button({}, 1, function()
                awful.spawn(button) end)
        }
    }
end

-- Battery bar
local bar_battery_prog = wibox.widget {
    max_value        = 100,
    forced_width     = bar_type == "vertical" and bar_size * 5/4 or bar_size * 5/6 * aspect_ratio,
    clip             = true,
    shape            = helpers.mkroundedrect(),
    bar_shape        = helpers.mkroundedrect(),
    background_color = beautiful.bg_focus,
    color            = beautiful.grn,
    widget           = wibox.widget.progressbar
}
local flipped_battery = wibox.widget {
    bar_battery_prog,
    direction = "east",
    widget    = wibox.container.rotate
}
local bar_battery_text     = status_widget()

-- I don't want to call this a systray... but
local bar_sound     = status_widget("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") -- Sound muted?
local bar_btn_sound = helpers.mkbtn(bar_sound,     beautiful.nbg, beautiful.lbg)
local bar_network   = status_widget() -- Network status?
local bar_btn_net   = helpers.mkbtn(bar_network,   beautiful.nbg, beautiful.lbg)
local bar_bluetooth = status_widget("bluetoothctl power off") -- Bluetooth on?
local bar_btn_blue  = helpers.mkbtn(bar_bluetooth, beautiful.nbg, beautiful.lbg)

-- The actual systray
local systray_btn = wibox.widget { 
    {
        {
            text    = "",
            font    = ic_font .. bar_size / 2.5,
            align   = "center",
            widget  = wibox.widget.textbox,
        },
        direction   = bar_pos == "left" and "north" or "south",
        widget      = wibox.container.rotate
    },
    bg     = beautiful.nbg,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background,
    buttons = {
        awful.button({}, 1, function()
            awesome.emit_signal('widget::systray')
        end)
    },
}
helpers.add_hover(systray_btn, beautiful.nbg, beautiful.lbg)
local systray_btn_h = wibox.widget {
    systray_btn,
    direction   = bar_pos == "top" and "east" or "west",
    widget      = wibox.container.rotate
}

-- Create a textclock widget
local vbar_clock = {
    {
        {
            {
                format = '<b>%H</b>',
                font   = mn_font .. bar_size / 3.4,
                halign = "center",
                widget = wibox.widget.textclock
            },
            {
                format = '<b>%M</b>',
                font   = mn_font .. bar_size / 4,
                halign = "center",
                widget = wibox.widget.textclock
            },
            layout  = wibox.layout.fixed.vertical
        },
        margins = bar_size / 8,
        widget  = wibox.container.margin
    },
    bg     = beautiful.titlebar_fg_normal,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background
}
local hbar_clock = {
    {
        {
            format = '<b>%H:%M</b>',
            font   = mn_font .. bar_size / 4,
            valign = "center",
            widget = wibox.widget.textclock
        },
        margins = bar_size / 8, 
        widget  = wibox.container.margin
    },
    bg     = beautiful.titlebar_fg_normal,
    shape  = helpers.mkroundedrect(),
    widget = wibox.container.background
}

-- Awesome Bar
--------------
-- The actual bar itself
screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8" }, s, awful.layout.layouts[1])

    local taglist_v = wibox.widget {
        {
            gettags(s),
            margins = bar_size / 3.6,
            widget  = wibox.container.margin
        },
        shape   = helpers.mkroundedrect(),
        bg      = beautiful.lbg,
        widget  = wibox.container.background
    }
    local taglist_h = wibox.widget {
        taglist_v,
        direction   = "east",
        widget      = wibox.container.rotate
    }
    s.mywibox = awful.wibar {
        visible  = bar_enabled,
        position = bar_pos,
        screen   = s,
        width    = bar_type == "horizontal" and scaling * 1.77 - beautiful.useless_gap * 3 or bar_size,
        height   = bar_type == "horizontal" and bar_size or scaling - beautiful.useless_gap * 3,
        shape    = helpers.mkroundedrect(),
        widget   = {
            {
                { -- Top Widgets
                    bar_dash,
                    bar_type == "horizontal" and taglist_h or taglist_v,
                    bar_launcher,
                    spacing = bar_size / 8,
                    layout  = bar_type == "horizontal" and wibox.layout.fixed.horizontal or wibox.layout.fixed.vertical,
                },
                { -- Middle Widgets
                    gettasks(s),
                    align  = "center",
                    widget = wibox.container.place
                },
                { -- Bottom Widgets
                    {
                        bar_type == "horizontal" and bar_battery_prog or flipped_battery,
                        {
                            bar_battery_text,
                            fg     = beautiful.bg_normal,
                            widget = wibox.container.background
                        },
                        visible = battery,
                        layout = wibox.layout.stack
                    },
                    bar_type == "horizontal" and systray_btn_h or systray_btn,
                    bar_type == "horizontal" and hbar_clock or vbar_clock,
                    {
                        bar_btn_sound,
                        {
                            bar_btn_blue,
                            visible = bluetoothctl,
                            widget  = wibox.container.background
                        },
                        bar_btn_net,
                        layout  = bar_type == "horizontal" and wibox.layout.fixed.horizontal or wibox.layout.fixed.vertical
                    },
                    {
                        {
                            getlayout(s),
                            margins = bar_size / 7,
                            widget  = wibox.container.margin
                        },
                        bg      = beautiful.lbg,
                        shape   = helpers.mkroundedrect(),
                        widget  = wibox.container.background
                    },
                    spacing = bar_size / 8,
                    layout  = bar_type == "horizontal" and wibox.layout.fixed.horizontal or wibox.layout.fixed.vertical,
                },
                layout = bar_type == "horizontal" and wibox.layout.align.horizontal or wibox.layout.align.vertical
            },
            margins = bar_size / 7,
            widget  = wibox.container.margin
        }
    }
end)

-- Bar Gaps to Edge
-------------------
local screen = awful.screen.focused()
if bar_pos == "right" then
    screen.mywibox.margins = {
        right   = beautiful.useless_gap
    }
elseif bar_pos == "left" then
    screen.mywibox.margins = {
        left    = beautiful.useless_gap
    }
elseif bar_pos == "bottom" then
    screen.mywibox.margins = {
        bottom  = beautiful.useless_gap
    }
else
    screen.mywibox.margins = {
        top     = beautiful.useless_gap
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
if battery then
    awesome.connect_signal("signal::battery", function(level, state, _, _, _)
        bar_battery_prog.value  = level
        -- 2 stands for discharging. For more information refer to:
        -- https://lazka.github.io/pgi-docs/UPowerGlib-1.0/enums.html#UPowerGlib.DeviceState
        if state ~= 2 then
            bar_battery_text.text = ""
            bar_battery_text.font = ic_font .. bar_size / 3
        else
            bar_battery_text.text = level
            bar_battery_text.font = ui_font .. "Bold " .. bar_size / 3.33
        end
    end)
end

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
