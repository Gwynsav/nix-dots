local awful     = require('awful')

local function toggle()
    awesome.connect_signal('signal::network', function(on)
        if on then
            awful.spawn('bluetoothctl power off')
        else
            awful.spawn('bluetoothctl power on')
        end
    end)
end

awesome.connect_signal('bluetooth::toggle', function() toggle() end)
