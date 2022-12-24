----------------------------
-- calendar for dashboard --
----------------------------

-- Imports
----------
local beautiful = require('beautiful')
local wibox     = require('wibox') 

local helpers   = require('helpers')

-- Calendar
-----------
local function calendar() 
    return wibox.widget {
        {
            {
                {
                    widget  = wibox.widget.calendar.month,
                    date    = os.date("*t"),
                    font    = ui_font .. dash_size / 56,
                    fn_embed = function(widget, flag, date) 
                        local focus_widget = wibox.widget {
                            text   = date.day,
                            align  = "center",
                            widget = wibox.widget.textbox,
                        }
                        local torender = flag == 'focus' and focus_widget or widget
                        if flag == 'header' then
                            torender.font = ui_font .. dash_size / 48
                        end
                        local colors = {
                            header  = beautiful.blu,
                            focus   = beautiful.ylw,
                            normal  = beautiful.dfg,
                            weekday = beautiful.gry,
                        }
                        local color = colors[flag] or beautiful.fg_normal
                        return wibox.widget {
                            {
                                torender,
                                margins = flag == 'focus' and dash_size / 100 or 0, 
                                widget  = wibox.container.margin
                            },
                            fg     = color,
                            bg     = flag == 'focus' and beautiful.blk or beautiful.lbg,
                            shape  = helpers.mkroundedrect(dash_size / 64),
                            widget = wibox.container.background
                        }
                    end
                },
                halign = "center",
                layout = wibox.container.place
            },
            margins = dash_size / 30,
            widget  = wibox.container.margin
        },
        forced_height = dash_size / 2,
        shape  = helpers.mkroundedrect(dash_size / 40),
        bg     = beautiful.lbg,
        widget = wibox.container.background
    }
end

return calendar
