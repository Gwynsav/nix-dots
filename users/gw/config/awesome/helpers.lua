-----------------------
-- Helpful functions --
-----------------------
-- Basically all of these are alpha's

-- Imports
----------
local awful     = require('awful')
local gears     = require('gears')
local wibox     = require('wibox')
local beautiful = require('beautiful')

local color     = require('modules.color')
local rubato    = require('modules.rubato')

-- Helpers
----------
local helpers = {}
-- create a transition animation function
function helpers.apply_transition(opts)
    opts = opts or {}
    local bg      = opts.bg  or beautiful.lbg
    local hbg     = opts.hbg or beautiful.blk
    local element = opts.element
    local prop    = opts.prop
    local background       = color.color { hex = bg }
    local hover_background = color.color { hex = hbg }
    local transition       = color.transition(background, hover_background, color.transition.RGB)
    local fading = rubato.timed {
        duration = 0.30,
    }
    fading:subscribe(function(pos)
        element[prop] = transition(pos / 100).hex
    end)
    return {
        on  = function()
            fading.target = 100
        end,
        off = function()
            fading.target = 0
        end
    }
end

-- add hover support to wibox.container.background-based elements
function helpers.add_hover(element, bg, hbg)
    local transition = helpers.apply_transition {
        element = element,
        prop    = 'bg',
        bg      = bg,
        hbg     = hbg,
    }
    element:connect_signal('mouse::enter', transition.on)
    element:connect_signal('mouse::leave', transition.off)
end

-- create a rounded rect using a custom radius
function helpers.mkroundedrect(radius)
    radius = radius or border_rad
    return function (cr, w, h)
        return gears.shape.rounded_rect(cr, w, h, radius)
    end
end

-- create a simple rounded-like button with hover support
function helpers.mkbtn(template, bg, hbg, radius)
    local button = wibox.widget {
        {
            template,
            margins = scaling / 270,
            widget  = wibox.container.margin,
        },
        bg     = bg,
        widget = wibox.container.background,
        shape  = helpers.mkroundedrect(radius),
    }
    if bg and hbg then
        helpers.add_hover(button, bg, hbg)
    end
    return button
end

return helpers
