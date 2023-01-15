-------------------------
-- dashboard: calendar --
-------------------------

-- Imports
----------
local beautiful = require('beautiful')
local wibox     = require('wibox') 
local dpi       = beautiful.xresources.apply_dpi

local helpers   = require('helpers')

-- Widgets
----------
local calendar_wdgt = wibox.widget {
    widget  = wibox.widget.calendar.month,
    date    = os.date("*t"),
    font    = ui_font .. dash_size / 96,
    flex_height = true,
    fn_embed = function(widget, flag, date) 
        local focus_widget = wibox.widget {
            text   = date.day,
            align  = "center",
            widget = wibox.widget.textbox,
        }
        local torender = flag == 'focus' and focus_widget or widget
        if flag == 'header' then
            torender.font = ui_font .. 0
        end
        local colors = {
            header  = beautiful.blu,
            focus   = beautiful.ylw,
            normal  = beautiful.wht,
            weekday = beautiful.gry,
        }
        local color = colors[flag] or beautiful.fg_normal
        return wibox.widget {
            {
                {
                    torender,
                    align  = "center",
                    widget = wibox.container.place
                },
                margins = flag == 'focus' and dpi(dash_size / 128) or 0, 
                widget  = wibox.container.margin
            },
            fg     = color,
            bg     = flag == 'focus' and beautiful.blk or beautiful.bg_normal,
            shape  = helpers.mkroundedrect(),
            forced_width = dpi(dash_width * 0.5),
            widget = wibox.container.background
        }
    end
}

local clock = wibox.widget {
    {
        {
           {
               {
                    format = "<b>%M</b>",
                    font   = mn_font .. dash_size / 48,
                    widget = wibox.widget.textclock
                },
                fg     = beautiful.wht,
                widget = wibox.container.background
            },
            align  = "center",
            layout = wibox.container.place
        },
        left   = dpi(dash_size / 64),
        top    = dpi(dash_size / 72),
        widget = wibox.container.margin
    },
    {
        {
           {
               {
                    format = "<b>%H</b>",
                    font   = ui_font .. dash_size / 48,
                    widget = wibox.widget.textclock
                },
                fg     = beautiful.blu,
                widget = wibox.container.background
            },
            align  = "center",
            layout = wibox.container.place
        },
        right  = dpi(dash_size / 64),
        bottom = dpi(dash_size / 72),
        widget = wibox.container.margin
    },
    layout = wibox.layout.stack
}

-- Calendar
-----------
local function calendar() 
    return wibox.widget {
        {
            {
                calendar_wdgt,
                left    = dpi(dash_size / 128),
                top     = dpi(-dash_size / 128),
                bottom  = dpi(dash_size / 128),
                right   = dpi(dash_size / 64),
                widget  = wibox.container.margin
            },
            {
                {
                    {
                        clock,
                        {
                            {
                                format = "%a %d\n",
                                align  = "center",
                                widget = wibox.widget.textclock
                            },
                            fg     = beautiful.gry,
                            widget = wibox.container.background
                        },
                        {
                            {
                                format = "<b>%b</b>\n%Y",
                                font   = ui_font .. dash_size / 64,
                                align  = "center",
                                widget = wibox.widget.textclock
                            },
                            fg     = beautiful.wht,
                            widget = wibox.container.background
                        },
                        layout = wibox.layout.fixed.vertical
                    },
                    align  = "center",
                    widget = wibox.container.place
                },
                bg     = beautiful.lbg,
                shape  = helpers.mkroundedrect(),
                forced_width = dpi(dash_size * 0.08),
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        forced_height = dpi(dash_size * 0.245),
        widget = wibox.container.background
    }
end

return calendar
