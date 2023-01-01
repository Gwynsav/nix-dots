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

-- User profile
local avatar  = wibox.widget {
    widget        = wibox.widget.imagebox,
    image         = beautiful.user_avatar,
    clip_shape    = gears.shape.circle,
    resize        = true,
    forced_height = dash_size / 12,
    forced_width  = dash_size / 12,
}

-- Little greeter message
local greeter = wibox.widget {
    markup = "Welcome, <b>user!</b>",
    font   = ui_font .. dash_size / 48,
    widget = wibox.widget.textbox
}
awful.spawn.easy_async_with_shell(
    "whoami", function(stdout)
        name           = stdout:match('(%w+)')
        greeter.markup = "<b>Hi,</b> " .. name
    end
)

-- Get your Uptime
local uptime = wibox.widget {
    text   = "Uptime unknown...",
    font   = ui_font .. dash_size / 96,
    widget = wibox.widget.textbox
}
-- oh god, please NixOS add `uptime -p`
-- update: (hiPrio procps) :euphoria:
local function get_uptime()
    awful.spawn.easy_async_with_shell(
        "uptime -p", function(stdout)
            uptime.text = stdout
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
            font   = ic_font .. dash_size / 48,
            align  = "center",
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
local shutdown_button = helpers.mkbtn(shutdown, beautiful.lbg, beautiful.gry);
local reboot   = txtbtn("", "systemctl reboot");
local reboot_button   = helpers.mkbtn(reboot,   beautiful.lbg, beautiful.gry);

local function user_profile()
    return wibox.widget {
    {
        {
            {
                {
                    avatar,
                    valign = "center",
                    layout = wibox.container.place
                },
                {
                    {
                        {
                            greeter, 
                            {
                                uptime,
                                fg     = beautiful.wht,
                                widget = wibox.container.background
                            },
                            spacing = - dash_size / 128,
                            layout  = wibox.layout.flex.vertical
                        },
                        valign = "center",
                        widget = wibox.container.place
                    },
                    left   = dash_size / 48,
                    right  = dash_size / 64,
                    widget = wibox.container.margin
                },
                layout  = wibox.layout.fixed.horizontal
            },
            left   = dash_size / 56,
            bottom = dash_size / 72,
            top    = dash_size / 72,
            right  = dash_size / 64,
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
            bg     = beautiful.blk,
            widget = wibox.container.background
        },
        layout = wibox.layout.align.vertical
    },
    shape  = helpers.mkroundedrect(),
    bg     = beautiful.lbg,
    forced_height = dash_size / 6.4,
    widget = wibox.container.background
}
end

return user_profile
