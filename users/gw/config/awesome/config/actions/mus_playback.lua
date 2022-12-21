-----------------------------
-- playerctl notifications --
-----------------------------

-- Imports
----------
local naughty   = require('naughty')
local bling     = require('modules.bling')
local playerctl = bling.signal.playerctl.lib()

-- Templates
------------
--[[ info_notif = naughty.notify { ]]
--[[         timeout = 1.5, ]]
--[[         image   = user_avatar ]]
--[[ } ]]

-- Notifications
----------------
-- Sends a notification every time the playerctl song changes.
local timeout    = 3
local info_first = true
playerctl:connect_signal("metadata",
                       function(_, title, artist, album_path, album, new, player_name)
    if info_first then
        info_first = false
    else
        --[[ info_notif.title = artist ]]
        --[[ info_notif.text  = title ]]
        --[[ info_notif.image = album_path ]]
        info_notif = naughty.notify({
            title = artist, text  = title, 
            timeout = timeout, image = album_path or user_avatar
        }, info_notif)
    end
end)

-- Sends a notification every time the playerctl playback status changes.
local stt_first  = true
playerctl:connect_signal("playback_status", function(playing, player_name)
    if stt_first then
        stt_first = false
    else
        if playing then
        end
    end
end)

-- Sends a notification every time the playerctl volume changes.
local vol_first  = true
playerctl:connect_signal("volume", function(volume, player_name)
    if vol_first then
        vol_first = false
    else
        vol_notif = naughty.notify({
            title   = "Music", 
            text    = "Song Volume at: " .. volume .. "%", 
            timeout = timeout
        }, vol_notif)
    end
end)
