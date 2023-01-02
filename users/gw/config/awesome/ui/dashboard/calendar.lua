----------------------------
-- calendar for dashboard --
----------------------------

-- Imports
----------
local beautiful = require('beautiful')
local wibox     = require('wibox') 

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
            torender.font = ui_font .. dash_size / 64
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
                torender,
                margins = flag == 'focus' and dash_size / 128 or 0, 
                widget  = wibox.container.margin
            },
            fg     = color,
            bg     = flag == 'focus' and beautiful.blk or beautiful.bg_normal,
            shape  = helpers.mkroundedrect(),
            forced_width = dash_size * 0.25,
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
        left   = dash_size / 64,
        top    = dash_size / 72,
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
        right  = dash_size / 64,
        bottom = dash_size / 72,
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
                right   = dash_size / 48,
                top     = dash_size / 64,
                widget  = wibox.container.margin
            },
            {
                {
                    {
                        clock,
                        {
                            {
                                format = "%a %d,\n%Y",
                                align  = "center",
                                widget = wibox.widget.textclock
                            },
                            fg     = beautiful.gry,
                            widget = wibox.container.background
                        },
                        layout = wibox.layout.align.vertical
                    },
                    align  = "center",
                    widget = wibox.container.place
                },
                bg     = beautiful.lbg,
                shape  = helpers.mkroundedrect(),
                forced_width = dash_size * 0.08,
                widget = wibox.container.background
            },
            layout = wibox.layout.fixed.horizontal
        },
        forced_height = dash_size / 4,
        widget = wibox.container.background
    }
end

return calendar
