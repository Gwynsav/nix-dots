-----------------------------
-- Layout Switching Script --
-----------------------------

-- Imports
----------
local awful     = require('awful')
local naughty   = require('naughty')
local bt        = require('beautiful')

local icon      = require('gears.filesystem').get_configuration_dir() .. "themes/assets/notification/language.svg"
local lang_icon = require('gears.color').recolor_image(icon, bt.notification_accent)

-- Language Switching
---------------------
awesome.connect_signal('signal::lang', function()
    awful.spawn.easy_async_with_shell(
        'setxkbmap -query | grep layout:', function(stdout)
            local default = stdout:match("latam")
            local content
            if default then
                awful.spawn('setxkbmap us -option caps:super')
                content = "American English"
            else
                awful.spawn('setxkbmap latam -option caps:super')
                content = "Latinamerican Spanish"
            end
            notif = naughty.notify({
                    title   = "Keyboard Layout", 
                    icon    = lang_icon,
                    text    = "Changed to " .. content,
                    timeout = 3
            }, notif)
    end)
end)
