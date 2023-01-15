-------------
-- Layouts --
-------------

-- Imports
----------
local awful         = require('awful')
local beautiful     = require('beautiful')
local gears         = require('gears')
local delayed_call  = require("gears.timer").delayed_call

local bling         = require('modules.bling')
local helpers       = require('helpers')

-- Layouts
----------
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.tile,
        awful.layout.suit.tile.left,
        awful.layout.suit.tile.bottom,
        bling.layout.centered,
        bling.layout.mstab,
        awful.layout.suit.floating,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)

-- External Padding
-------------------
-- This is added ON TOP of the 'beautiful.useless_gap' value
awful.screen.connect_for_each_screen(function(s)
    s.padding = {
        left   = outer_gaps - inner_gaps, 
        right  = outer_gaps - inner_gaps, 
        top    = outer_gaps - inner_gaps, 
        bottom = outer_gaps - inner_gaps
    }
end)

-- Rounded Corners
------------------
client.connect_signal("request::manage", function(c)
    c.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, beautiful.border_radius)
    end
end)
