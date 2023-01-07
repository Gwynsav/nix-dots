--------------------------
-- volume notifications --
--------------------------

local naughty = require('naughty')

-- Sends a notification every time the content of the volume signal
-- is modified.
local timeout = 1.5
local first   = true
awesome.connect_signal('signal::volume', function(volume, muted)
    if first then
        first = false
    else
        local message
        if muted then
            message = "Volume Muted"
        else
            message = "Volume set to " .. tostring(volume) .. "%"
        end
        notif = naughty.notification({
                title = "System Audio", message = message, 
                timeout = timeout, app_name = "volume" 
            }, notif)
    end
end)
