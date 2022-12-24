local awful = require('awful')

awesome.connect_signal('signal::lang', function()
    awful.spawn.easy_async_with_shell(
        'setxkbmap -query | grep layout:', function(stdout)
            local default = stdout:match("latam")
            if default then
                awful.spawn('setxkbmap us -option caps:super')
            else
                awful.spawn('setxkbmap latam -option caps:super')
            end
    end)
end)
