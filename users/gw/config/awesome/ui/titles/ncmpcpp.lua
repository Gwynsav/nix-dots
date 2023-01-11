-----------------------
-- custom ncmpcpp ui --
-----------------------

-- Imports
----------
local awful     = require('awful')
local beautiful = require('beautiful')
local ruled     = require('ruled')

local helpers   = require('helpers')

-- Widgets
----------

-- Signals
----------

-- Client Decoration
--------------------
local ncmpcpp_ui = function(c)
    -- Unbind default titlebar
    awful.titlebar.hide(c, beautiful.titles_pos)

    -- Bind custom titlebar
    --[[ c.custom_decoration = { top = true, left = true, bottom = true } ]]
end

ruled.client.connect_signal("request::rules", function()
    ruled.client.append_rule({
        id       = "music",
        rule     = { instance = "music" },
        callback = ncmpcpp_ui
    })
end)
