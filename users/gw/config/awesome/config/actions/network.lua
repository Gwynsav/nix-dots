local awful     = require('awful')

local function toggle()
    awesome.connect_signal('signal::network', function(on)
        if on then
            awful.spawn('nmcli networking off')
        else
            awful.spawn('nmcli networking on')
        end
    end)
end

awesome.connect_signal('network::toggle', function() toggle() end)
