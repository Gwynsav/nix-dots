local awful     = require('awful')
local naughty   = require('naughty')

-- Sends a notification every time the content of the bluetooth signal
-- is modified.
local timeout = 2
local first   = true
awesome.connect_signal('signal::bluetooth', function(powered)
    if first then
        first = false
    else
        local message = powered and "Bluetooth ON!" or "Bluetooth OFF!"
        notif = naughty.notification({
                title = "Connectivity", message = message, 
                timeout = timeout, app_name = "bluetooth" 
            }, notif)
    end
end)
