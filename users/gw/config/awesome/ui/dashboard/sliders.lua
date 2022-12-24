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
local function makeslider()
    return wibox.widget {
        {
            bar_shape           = gears.shape.rounded_bar,
            bar_height          = dash_size / 15,
            bar_color           = beautiful.blk,
            bar_active_color    = beautiful.blu,
            handle_color        = beautiful.blu,
            handle_shape        = gears.shape.circle,
            handle_border_width = 0,
            handle_width        = dash_size / 13,
            minimum             = 0,
            maximum             = 100,
            widget              = wibox.widget.slider
        }
    }
end
local function makeicon()
    return wibox.widget {
        font    = ic_font .. dash_size / 40,
        align   = "center",
        widget  = wibox.widget.textbox
    }
end

local volume_slider     = makeslider()
local volume_status     = makeicon()
local brightness_slider = makeslider()
local brightness_status = makeicon()
local battery_slider    = makeslider()
local battery_status    = makeicon()

-- Signals
----------
-- Volume signal
awesome.connect_signal("signal::volume", function(volume, muted)
    volume_slider.value = volume
    if muted then
        volume_status.text = ""
    else
        volume_status.text = ""
    end
end)

-- Brightness signal
if brightness then
    awesome.connect_signal("signal::brightness", function(brightness)
        brightness_slider.value = brightness
    end)
end

-- Battery signal
if battery then
    awesome.connect_signal("signal::battery", function(level, charging)
        battery_slider.value    = level
        if charging then
            battery_status.text = ""
            battery_status.font = ic_font .. bar_size / 3
        else
            battery_status.text = level
            battery_status.font = ui_font .. "Bold " .. bar_size / 3.33
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
                    volume_slider,
                    {
                        {
                            volume_status,
                            fg     = beautiful.lbg,
                            widget = wibox.container.background,
                        },
                        halign = "left",
                        layout = wibox.container.place
                    },
                    layout = wibox.layout.stack
                },
                {
                    brightness_slider,
                    {
                        {
                            brightness_status,
                            fg     = beautiful.lbg,
                            widget = wibox.container.background,
                        },
                        halign = "left",
                        layout = wibox.container.place
                    },
                    visible = brightness,
                    layout  = wibox.layout.stack
                },
                {
                    battery_slider,
                    {
                        {
                            battery_status,
                            fg     = beautiful.lbg,
                            widget = wibox.container.background,
                        },
                        halign = "left",
                        layout = wibox.container.place
                    },
                    visible = battery,
                    layout  = wibox.layout.stack
                },
                layout = wibox.layout.fixed.vertical
            },
            margins = dash_size / 20,
            widget  = wibox.container.margin
        },
        shape  = helpers.mkroundedrect(dash_size / 40),
        bg     = beautiful.lbg,
        forced_height = dash_size / 2.5,
        widget = wibox.container.background
    }
end

return sliderbox
