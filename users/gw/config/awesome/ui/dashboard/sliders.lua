------------------------
-- dashboard: sliders --
------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 

local helpers   = require('helpers')

-- Widgets
----------
local function makeslider(base_icon, color)
    return wibox.widget {
        {
            {
                id      = 'icon_role',
                text    = base_icon,
                font    = ic_font .. dash_size / 56,
                align   = "center",
                widget  = wibox.widget.textbox
            },
            fg      = color,
            widget  = wibox.container.background
        },
        {
            id                  = 'slider_role',
            bar_shape           = helpers.mkroundedrect(),
            bar_height          = dash_size / 172,
            bar_color           = beautiful.blk,
            bar_active_color    = color,
            handle_color        = color,
            handle_shape        = gears.shape.circle,
            handle_border_color = beautiful.lbg,
            handle_border_width = dash_size / 256,
            handle_width        = dash_size / 48,
            minimum             = 0,
            maximum             = 100,
            widget              = wibox.widget.slider
        },
        spacing = dash_size / 72,
        layout  = wibox.layout.fixed.horizontal,
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
local volumebar = makeslider("", beautiful.blu)
awesome.connect_signal("signal::volume", function(volume, muted)
    volumebar.value = volume
    volumebar.icon  = muted and "" or ""
end)
volumebar.slider:connect_signal('property::value', function(_, value)
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ " .. tonumber(value) .. "%")
end)

-- Microphone
-------------
local mic        = makeslider("", beautiful.mag)
awesome.connect_signal("signal::microphone", function(mic_level, mic_muted)
    mic.value = mic_level
    mic.icon = mic_muted and "" or ""
end)
mic.slider:connect_signal('property::value', function(_, value)
    awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SOURCE@ " .. tonumber(value) .. "%")
end)

-- Brightness
-------------
local brightbar = makeslider("", beautiful.ylw)
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
        {
            {
                volumebar,
                mic,
                brightness and brightbar,
                spacing = dash_size / 72,
                layout  = wibox.layout.flex.vertical
            },
            margins = dash_size / 30,
            widget  = wibox.container.margin
        },
        shape  = helpers.mkroundedrect(),
        bg     = beautiful.lbg,
        forced_height = dash_size * 0.18,
        widget = wibox.container.background
    }
end

return sliderbox
