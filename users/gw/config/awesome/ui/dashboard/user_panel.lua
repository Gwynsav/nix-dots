---------------------------
-- dashboard: user panel --
---------------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local gears     = require('gears') 
local wibox     = require('wibox') 

local helpers   = require('helpers')

-- User profile support
local avatar  = wibox.widget {
    widget     = wibox.widget.imagebox,
    image      = beautiful.user_avatar,
    clip_shape = helpers.mkroundedrect(dash_size / 40),
    resize     = true,
    forced_height         = dash_size / 12,
    forced_width          = dash_size / 12,
    vertical_fit_policy   = "fit",
    horizontal_fit_policy = "fit"
}

-- Little greeter message
local greeter = wibox.widget {
    markup = "Welcome, <b>user!</b>",
    font   = ui_font .. dash_size / 50,
    widget = wibox.widget.textbox
}
awful.spawn.easy_async_with_shell(
    "whoami", function(stdout)
        name           = stdout:match('(%w+)')
        greeter.markup = "<b>Hello,</b> " .. name
    end
)

-- Get your Uptime
local uptime = wibox.widget {
    markup = "Uptime <b>unknown</b>...",
    font   = ui_font .. dash_size / 64,
    widget = wibox.widget.textbox
}
local function get_uptime()
    awful.spawn.easy_async_with_shell(
        "uptime -p | tr -d 'outep'", function(stdout)
            uptime.markup = "•<i>" .. stdout .. "</i>"
        end)
end
gears.timer {
    timeout   = 60,
    call_now  = true,
    autostart = true,
    callback  = get_uptime
}

local function txtbtn(icon, action)
    return wibox.widget {
        {
            text   = icon,
            font   = ic_font .. dash_size / 40,
            valign = "center",
            halign = "center",
            widget = wibox.widget.textbox,
            buttons = {
                awful.button({}, 1, 
                    function() awful.spawn(action) end)
            }
        },
        fg     = beautiful.red,
        widget = wibox.container.background
    } 
end

local shutdown = txtbtn("", "systemctl poweroff");
local shutdown_button = helpers.mkbtn(shutdown, beautiful.lbg, beautiful.gry, dash_size / 80);
local reboot   = txtbtn("", "systemctl reboot");
local reboot_button   = helpers.mkbtn(reboot,   beautiful.lbg, beautiful.gry, dash_size / 80);

local function user_profile()
    return wibox.widget {
    {
        {
            {
                avatar,
                {
                    {
                        {
                            greeter, 
                            uptime,
                            layout = wibox.layout.flex.vertical
                        },
                        valign = "center",
                        layout = wibox.container.place
                    },
                    left   = dash_size / 40,
                    right  = dash_size / 40,
                    widget = wibox.container.margin
                },
                valign  = "center",
                layout  = wibox.layout.fixed.horizontal
            },
            left   = dash_size / 30,
            bottom = dash_size / 40,
            top    = dash_size / 40,
            right  = dash_size / 30,
            widget = wibox.container.margin
        },
        {
            {
                {
                    {
                        reboot_button,
                        shutdown_button,
                        spacing = dash_size / 220,
                        layout  = wibox.layout.flex.horizontal
                    },
                    halign = "right",
                    layout = wibox.container.place
                },
                right  = dash_size / 110,
                widget = wibox.container.margin
            },
            forced_height = dash_size / 10,
            bg     = beautiful.blk,
            widget = wibox.container.background
        },
        layout = wibox.layout.align.vertical
    },
    shape  = helpers.mkroundedrect(dash_size / 40),
    bg     = beautiful.lbg,
    forced_height = dash_size / 5.3,
    widget = wibox.container.background
}
end

return user_profile
