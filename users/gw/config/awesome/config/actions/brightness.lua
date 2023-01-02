local naughty = require('naughty')

-- Sends a notification every time the content of the bluetooth signal
-- is modified.
local timeout = 1.5
local first   = true
awesome.connect_signal('signal::brightness', function(brightness)
    if first then
        first = false
    else
        local message
        message = "Brightness set to " .. tostring(brightness) .. "%"
        notif = naughty.notification({
                title = "Screen Brightness", message = message, 
                timeout = timeout, app_name = "brightness" 
            }, notif)
    end
end)
