---------------------------------
-- quick actions for dashboard --
---------------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 

local helpers   = require('helpers')

-- Buttons
----------
-- Status icons
local function status_widget(action)
    return wibox.widget {
        font   = ic_font .. dash_size / 56,
        align  = "center",
        widget = wibox.widget.textbox,
        buttons = {
            awful.button({}, 1, function(action)
                awful.spawn(action) end)
        }
    }
end

-- Network
local dash_network   = wibox.widget {
    font   = ic_font .. dash_size / 56,
    align  = "center",
    widget = wibox.widget.textbox,
}
dash_network:connect_signal("button::press", function()
    awful.spawn(
        [[bash -c "
            [ $(nmcli networking connectivity check) = "full" ] && nmcli networking off || nmcli networking on
        "]])
end)
-- Bluetooth
local dash_bluetooth =  wibox.widget {
    font   = ic_font .. dash_size / 56,
    align  = "center",
    widget = wibox.widget.textbox,
}
dash_bluetooth:connect_signal("button::press", function()
    awful.spawn(
        [[bash -c "
            [ $(bluetoothctl show | grep -i powered: | awk '{print $2}') = "yes" ] && bluetoothctl power off || bluetoothctl power on
        "]])
end)
-- Audio
local dash_audio     = wibox.widget {
    font   = ic_font .. dash_size / 56,
    align  = "center",
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function(action)
            awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end)
    }
}
-- Microphone
local dash_mic      = wibox.widget {
    font   = ic_font .. dash_size / 56,
    align  = "center",
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function(action)
            awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") end)
    }
}

-- Quick Actions
----------------
local function qk_actions()
    return wibox.widget {
        {
            {
                helpers.mkbtn(dash_network, beautiful.blk, beautiful.grn_d),
                bluetoothctl and helpers.mkbtn(dash_bluetooth, beautiful.blk, beautiful.blu_d),
                helpers.mkbtn(dash_audio, beautiful.blk, beautiful.cya_d),
                helpers.mkbtn(dash_mic, beautiful.blk, beautiful.mag_d),
                spacing = dash_size / 96,
                layout  = wibox.layout.flex.horizontal
            },
            margins = dash_size / 72,
            widget  = wibox.container.margin
        },
        bg     = beautiful.lbg,
        shape  = helpers.mkroundedrect(),
        forced_height = dash_size / 10,
        widget = wibox.container.background
    }
end

-- Signal Connections
---------------------
awesome.connect_signal("signal::network", function(is_enabled)
    dash_network.text = is_enabled and "" or ""
end)
if bluetoothctl then
    awesome.connect_signal("signal::bluetooth", function(is_enabled)
        dash_bluetooth.text = is_enabled and "" or ""
    end)
end

awesome.connect_signal("signal::volume", function(level, muted)
    dash_audio.text = muted and "" or ""
end)
awesome.connect_signal("signal::microphone", function(mic_level, mic_muted)
    dash_mic.text = mic_muted and "" or ""
end)

return qk_actions
