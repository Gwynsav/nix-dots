local awful     = require('awful')
local naughty   = require('naughty')

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
                    title = "Keyboard Language", 
                    text = "Changed to " .. content
            }, notif)
    end)
end)
