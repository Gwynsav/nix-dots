------------------------
-- dashboard: sliders --
------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Widgets
----------
local function makeslider(base_icon, color, input)
    return wibox.widget {
        {
            {
                {
                    {
                        {
                            id      = 'icon_role',
                            text    = base_icon,
                            font    = ic_font .. dash_size / 56,
                            align   = "center",
                            widget  = wibox.widget.textbox
                        },
                        margins = dash_size / 192,
                        widget  = wibox.container.margin
                    },
                    fg      = color,
                    bg      = beautiful.blk,
                    shape   = helpers.mkroundedrect(),
                    widget  = wibox.container.background,
                    buttons = {
                        awful.button({}, 1, function()
                            awful.spawn(input)
                        end)
                    }
                },
                {
                    {
                        id                  = 'slider_role',
                        bar_shape           = helpers.mkroundedrect(),
                        bar_height          = dpi(dash_size / 172),
                        bar_color           = beautiful.blk,
                        bar_active_color    = color,
                        handle_color        = color,
                        handle_shape        = gears.shape.circle,
                        handle_width        = dpi(dash_size / 64),
                        minimum             = 0,
                        maximum             = 100,
                        widget              = wibox.widget.slider
                    },
                    direction = "east",
                    widget    = wibox.container.rotate
                },
                spacing = dpi(dash_size / 72),
                layout  = wibox.layout.fixed.vertical
            },
            top     = dpi(dash_size / 64),
            bottom  = dpi(dash_size / 64),
            left    = dpi(dash_size / 128),
            right   = dpi(dash_size / 128),
            widget  = wibox.container.margin
        },
        bg     = beautiful.lbg,
        shape  = helpers.mkroundedrect(),
        widget = wibox.container.background,
        get_slider = function(self)
            return self:get_children_by_id('slider_role')[1]
        end,
        set_value  = function(self, val)
            self.slider.value = val
        end,
        set_icon   = function(self, new_icon)
            self:get_children_by_id('icon_role')[1].text = new_icon
        end
    }
end

-- Volume
---------
local volumebar = makeslider("", beautiful.blu, "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
awesome.connect_signal("signal::volume", function(volume, muted)
    volumebar.value = volume
    volumebar.icon  = muted and "" or ""
end)
volumebar.slider:connect_signal('property::value', function(_, value)
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. tonumber(value) .. "%")
end)

-- Microphone
-------------
local mic        = makeslider("", beautiful.mag, "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")
awesome.connect_signal("signal::microphone", function(mic_level, mic_muted)
    mic.value = mic_level
    mic.icon = mic_muted and "" or ""
end)
mic.slider:connect_signal('property::value', function(_, value)
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ " .. tonumber(value) .. "%")
end)

-- Brightness
-------------
local brightbar = makeslider("", beautiful.ylw, nil)
if brightness then
    awesome.connect_signal("signal::brightness", function(brightness)
        brightbar.value = brightness
        if brightness <= 33 then 
            brightbar.icon  = ""
        elseif brightness <= 66 then
            brightbar.icon  = ""
        else
            brightbar.icon  = ""
        end
    end)
end
brightbar.slider:connect_signal('property::value', function(_, value)
    awful.spawn("brightnessctl -d intel_backlight set " .. tonumber(value) .. "%")
end)

-- Sliders
----------
local function sliderbox()
    return wibox.widget {
        volumebar,
        mic,
        brightness and brightbar,
        spacing = dpi(dash_size / 80),
        layout  = wibox.layout.flex.vertical
    }
end

return sliderbox
