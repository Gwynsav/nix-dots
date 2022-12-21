---------------------------------
-- quick actions for dashboard --
---------------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi
local gfs       = gears.filesystem

local helpers   = require('helpers')

-- Widgets
----------
-- Text buttons thingy
local function mktxtbtn(action)
    return wibox.widget {
        font    = ic_font .. dash_size / 40,
        align   = "center",
        widget  = wibox.widget.textbox,
        button  = {
            awful.button({}, 1, function()
                awful.spawn(action) end)
        }
    }
end

-- Buttons
local dash_network   = mktxtbtn(gfs.get_configuration_dir() .. "ui/dashboard/scripts/net")
local dash_net_btn   = helpers.mkbtn(dash_network,   beautiful.blk, beautiful.gry, dash_size / 48)
local dash_bluetooth = mktxtbtn(gfs.get_configuration_dir() .. "ui/dashboard/scripts/blu")
local dash_blu_btn   = helpers.mkbtn(dash_bluetooth, beautiful.blk, beautiful.gry, dash_size / 48)
local dash_audio     = mktxtbtn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
local dash_audio_btn = helpers.mkbtn(dash_audio,     beautiful.blk, beautiful.gry, dash_size / 48)

-- Quick Actions
----------------
local function qk_actions()
    return wibox.widget {
        {
            {
                dash_net_btn,
                dash_blu_btn,
                dash_audio_btn,
                spacing = dash_size / 96,
                layout  = wibox.layout.flex.horizontal
            },
            margins = dash_size / 48,
            widget  = wibox.container.margin
        },
        bg     = beautiful.lbg,
        shape  = helpers.mkroundedrect(dash_size / 40),
        widget = wibox.container.background
    }
end

-- Signal Connections
---------------------
awesome.connect_signal("signal::network", function(is_enabled)
    dash_network.text = is_enabled and "" or ""
end)

awesome.connect_signal("signal::bluetooth", function(is_enabled)
    dash_bluetooth.text = is_enabled and "" or ""
end)

awesome.connect_signal("signal::volume", function(level, muted)
    dash_audio.text = muted and "" or ""
end)

return qk_actions
