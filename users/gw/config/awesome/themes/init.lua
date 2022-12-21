------------
-- oh boy --
------------
local beautiful = require('beautiful')
local gears     = require('gears')
local gfs       = gears.filesystem

beautiful.init(gfs.get_configuration_dir() .. "themes/theme.lua")
