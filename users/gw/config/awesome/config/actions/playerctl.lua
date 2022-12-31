-----------------------------
-- playerctl notifications --
-----------------------------

-- Imports
----------
local naughty   = require('naughty')
local bling     = require('modules.bling')
local playerctl = bling.signal.playerctl.lib()

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
        info_notif = naughty.notify({
            title = artist, text  = title, 
            timeout = timeout, image = album_path or user_avatar
        }, info_notif)
    end
end)
