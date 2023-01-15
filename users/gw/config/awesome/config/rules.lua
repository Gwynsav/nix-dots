--------------
-- WM Rules --
--------------

-- Imports
----------
local awful     = require('awful')
local ruled     = require('ruled')
local beautiful = require('beautiful')
local gears     = require('gears')

-- Rules
--------
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus             = awful.client.focus.filter,
            raise             = true,
            size_hints_honor  = false,
            screen            = awful.screen.preferred,
            placement         = awful.placement.centered+awful.placement.no_overlap+awful.placement.no_offscreen,
            callback          = awful.client.setslave
        }
    }
    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Gpick", "Sxiv", "Tor Browser", 
                "Gucharmap", "Lxappearance", "Pavucontrol",
                "Galculator", "feh"
            },
            name    = {
                "Event Tester", "Friends List",
            },
            role    = {
                "AlarmWindow", "ConfigManager",
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { 
            floating  = true, 
            placement = awful.placement.centered+awful.placement.no_offscreen
        }
    }
    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        except_any = { class = { "feh", } },
        properties = { titlebars_enabled = title_enable }
    }
    -- App Rules
    ------------
    -- Set Steam to always map on the tag named "7".
    ruled.client.append_rule {
        rule       = { class = "Steam" },
        properties = { tag   = "7"     }
    }
    -- Set Discord and Revolt to map to tag "6".
    ruled.client.append_rule {
        rule       = {
            class = { "discord", "Revolt" }
        },
        properties = { tag   = "6" }
    }
end)

-- Makes floating windows always stay on top
client.connect_signal("property::floating", function(c)
    if c.floating then
        c.ontop = true
    else
        c.ontop = false
    end
end)
