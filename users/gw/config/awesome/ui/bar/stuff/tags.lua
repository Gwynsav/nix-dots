----------------------
-- animated taglist --
----------------------

-- stolen from Alpha with love <3
local awful   = require('awful')
local wibox   = require('wibox')
local gears   = require('gears')

local helpers = require('helpers')
local rubato  = require('modules.rubato')

local multiplier = 1
if bar_type == "horizontal" then
    multiplier = aspect_ratio
end

local function gettaglist(s)
    return awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        style = {
            shape = helpers.mkroundedrect(bar_size / 7),
        },
        layout = {
            spacing = bar_size / 4,
            layout  = wibox.layout.fixed.vertical,
        },
        buttons = {
            awful.button({}, 1, function (t)
                t:view_only()
            end),
            awful.button({}, 4, function (t)
                awful.tag.viewprev(t.screen)
            end),
            awful.button({}, 5, function (t)
                awful.tag.viewnext(t.screen)
            end)
        },
        widget_template = {
            {
                markup = '',
                widget = wibox.widget.textbox,
            },
            id = 'background_role',
            forced_height = (bar_size / 1.5) * multiplier,
            forced_width  = (bar_size / 6) * multiplier,
            widget = wibox.container.background,
            create_callback = function (self, tag)
                self.animate = rubato.timed {
                    duration = 0.15,
                    subscribed = function (h)
                        self:get_children_by_id('background_role')[1].forced_height = h
                    end
                }

                self.update = function ()
                    if tag.selected then
                        self.animate.target = (bar_size / 1.5 + 1) * multiplier
                    elseif #tag:clients() > 0 then
                        self.animate.target = (bar_size / 1.5 - bar_size / 6) * multiplier
                    else
                        self.animate.target = (bar_size / 6 + 1) * multiplier
                    end
                end

                self.update()
            end,
            update_callback = function (self)
                self.update()
            end,
        }
    }
end

return gettaglist
