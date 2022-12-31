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
local dash_network   = status_widget("awesome.emit_signal('network::toggle')")
local dash_net_btn   = helpers.mkbtn(dash_network, beautiful.blk, beautiful.gry)
-- Bluetooth
local dash_bluetooth = status_widget("awesome.emit_signal('bluetooth::signal')")
local dash_blu_btn   = helpers.mkbtn(dash_bluetooth, beautiful.blk, beautiful.gry)
-- Audio
local dash_audio     = status_widget("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
local dash_audio_btn = helpers.mkbtn(dash_audio, beautiful.blk, beautiful.gry)
-- Microphone
local dash_mic       = status_widget("wpctl set-mute @DEFAULT_AUDIO_SOURCE toggle")
local dash_mic_btn   = helpers.mkbtn(dash_mic, beautiful.blk, beautiful.gry)

-- Quick Actions
----------------
local function qk_actions()
    return wibox.widget {
        {
            {
                dash_net_btn,
                bluetoothctl and dash_blu_btn,
                dash_audio_btn,
                dash_mic_btn,
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
awesome.connect_signal("signal::microphone", function(level, muted)
    dash_mic.text = muted and "" or ""
end)

return qk_actions
