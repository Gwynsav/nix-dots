---------------------------
-- sliders for dashboard --
---------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 

local helpers   = require('helpers')

-- Widgets
----------
local function makeslider(color)
    return wibox.widget {
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
    }
end
local function makeicon()
    return wibox.widget {
        font    = ic_font .. dash_size / 48,
        align   = "center",
        widget  = wibox.widget.textbox
    }
end

local volume_slider     = makeslider(beautiful.blu)
local volume_status     = makeicon()
local mic_slider        = makeslider(beautiful.mag)
local mic_status        = makeicon()
local brightness_slider = makeslider(beautiful.ylw)
local brightness_status = makeicon()
local battery_slider    = makeslider(beautiful.grn)
local battery_status    = makeicon()

-- Signals
----------
-- Volume signal
awesome.connect_signal("signal::volume", function(volume, muted)
    volume_slider.value = volume
    volume_status.text = muted and "" or ""
end)

-- Microphone signal
awesome.connect_signal("signal::microphone", function(mic_level, mic_muted)
    mic_slider.value = mic_level
    mic_status.text = mic_muted and "" or ""
end)

-- Brightness signal
awesome.connect_signal("signal::brightness", function(brightness)
    brightness_slider.value = brightness
    if brightness <= 33 then 
        brightness_status.text  = ""
    elseif brightness <= 66 then
        brightness_status.text  = ""
    else
        brightness_status.text  = ""
    end
end)

-- Battery signal
if battery then
    awesome.connect_signal("signal::battery", function(level, charging)
        battery_slider.value    = level
        if charging then
            battery_status.text = ""
            battery_status.font = ic_font .. dash_size / 48
        else
            battery_status.text = level
            battery_status.font = ui_font .. "Bold " .. dash_size / 48
        end
    end)
end

-- Sliders
----------
local function sliderbox()
    return wibox.widget {
        {
            {
                {
                    {
                        volume_status,
                        fg     = beautiful.blu,
                        widget = wibox.container.background
                    },
                    volume_slider,
                    spacing = dash_size / 72,
                    layout  = wibox.layout.fixed.horizontal
                },
                {
                    {
                        mic_status,
                        fg     = beautiful.mag,
                        widget = wibox.container.background
                    },
                    mic_slider,
                    spacing = dash_size / 72,
                    layout  = wibox.layout.fixed.horizontal
                },
                {
                    {
                        brightness_status,
                        fg     = beautiful.ylw,
                        widget = wibox.container.background
                    },
                    brightness_slider,
                    spacing = dash_size / 72,
                    layout  = wibox.layout.fixed.horizontal
                },
                {
                    {
                        battery_status,
                        fg     = beautiful.grn,
                        widget = wibox.container.background
                    },
                    battery_slider,
                    spacing = dash_size / 72,
                    visible = battery,
                    layout  = wibox.layout.fixed.horizontal
                },
                spacing = dash_size / 72,
                layout  = wibox.layout.flex.vertical
            },
            margins = dash_size / 30,
            widget  = wibox.container.margin
        },
        shape  = helpers.mkroundedrect(),
        bg     = beautiful.lbg,
        forced_height = dash_size * 0.2,
        widget = wibox.container.background
    }
end

return sliderbox
