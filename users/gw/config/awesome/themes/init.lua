------------
-- oh boy --
------------
local beautiful = require('beautiful')
local gfs       = require('gears.filesystem')

beautiful.init(gfs.get_configuration_dir() .. "themes/theme.lua")
