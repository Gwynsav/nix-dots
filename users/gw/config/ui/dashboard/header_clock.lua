-- Imports
----------
local beautiful = require('beautiful')
local wibox     = require('wibox') 

local helpers   = require('helpers')

-- Clock
--------
local function date_header()
    return wibox.widget {
        {
            {
                {
                    {
                        {
                            {
                                {
                                    {
                                        format = "%M",
                                        font   = ui_font .. dash_size / 15,
                                        widget = wibox.widget.textclock
                                    },
                                    fg     = beautiful.blu,
                                    widget = wibox.container.background
                                },
                                left   = dash_size / 12,
                                top    = dash_size / 48,
                                widget = wibox.container.margin
                            },
                            align  = "center",
                            layout = wibox.container.place
                        },
                        {
                            {
                                {
                                    format = "<b>%H</b>",
                                    font   = ui_font .. dash_size / 15,
                                    widget = wibox.widget.textclock
                                },
                                right  = dash_size / 12,
                                bottom = dash_size / 48,
                                widget = wibox.container.margin
                            },
                            align  = "center",
                            layout = wibox.container.place
                        },
                        layout = wibox.layout.stack
                    },
                    {
                        {
                            {
                                markup = "<b>" .. os.date("%A %d") .. "</b>",
                                font   = ui_font .. dash_size / 48,
                                widget = wibox.widget.textbox
                            },
                            fg     = beautiful.gry,
                            widget = wibox.container.background
                        },
                        align  = "center",
                        layout = wibox.container.place
                    },
                    spacing = dash_size / 60,
                    layout  = wibox.layout.fixed.horizontal
                },
                align  = "center",
                layout = wibox.container.place
            },
            margins = dash_size / 96,
            widget  = wibox.container.margin
        },
        bg     = beautiful.lbg,
        shape  = helpers.mkroundedrect(dash_size / 48),
        widget = wibox.container.background
    }
end

return date_header
