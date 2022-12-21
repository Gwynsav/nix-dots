------------------------------------
-- notification log for dashboard --
------------------------------------
-- for the time being this is just a
-- placeholder. Look forward to it!

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Widgets
----------


-- Notification Log
-------------------
local function notif_log()
    return wibox.widget {
        {
            wibox.widget.textbox("This is a placeholder...\nImagine a notification center here."),
            align  = "center",
            layout = wibox.container.place
        },
        fg     = beautiful.gry,
        bg     = beautiful.lbg,
        shape  = helpers.mkroundedrect(dash_size / 40),
        widget = wibox.container.background
    }
end

return notif_log
