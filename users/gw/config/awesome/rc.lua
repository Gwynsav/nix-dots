-----------------------------
-- gwdawful awesome config --
-----------------------------
-- Refer to 'userconf.lua' for proper customization configuration.
-- I've minimized interaction with this file to keep every separate
-- kind of configuration within its own dedicated directory/file.

-- Imports
----------
pcall(require, 'luarocks.loader')
local awful     = require('awful')
local beautiful = require('beautiful')
local naughty   = require('naughty')

-- Error Handling
-----------------
-- I will insist very hard on this. This should ALWAYS be the FIRST 
-- thing in any AwesomeWM configuration. Moving this block may affect
-- error traceback notifications, making troubleshooting harder.
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- Files
--------
-- Contains general user configuration.
require('userconf')
-- Contains the theming configuration.
require('themes')
-- Contains custom managed signals.
require('signals')
-- Contains the window manager configuration, like keybinds and rules.
require('config')
-- Contains the UI configuration.
require('ui')

-- Garbage Collection
---------------------
-- Utilize lua garbage cleanup, helps with resource usage.
collectgarbage('setpause',   110)
collectgarbage('setstepmul', 1000)
