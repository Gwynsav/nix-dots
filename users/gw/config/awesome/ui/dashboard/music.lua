-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local gfs       = require('gears.filesystem')

local helpers   = require('helpers')
local bling     = require('modules.bling')
local playerctl = bling.signal.playerctl.lib()

-- Widgets
----------
local album_art = wibox.widget {
    -- image  = gfs.get_configuration_dir() .. "theme/assets/default/player.png",
    image  = gfs.get_configuration_dir() .. "theme/assets/default/user.png",
    resize = true,
    clip_shape    = helpers.mkroundedrect(),
    forced_height = dash_size * 0.4,
    widget = wibox.widget.imagebox
}

local function sng_info(default, size)
    return wibox.widget {
        markup = default,
        font   = ui_font .. dash_size / size,
        widget = wibox.widget.textbox
    }
end
local sng_title  = sng_info("<b>Nothing Playing</b>", 40)
local sng_artist = sng_info("by <i>Unknown</i>", 60)
local sng_album  = sng_info("on <i>Untitled</i>", 60)

local sng_progress = wibox.widget {
    color     = beautiful.grn,
    background_color = beautiful.lbg,
    shape     = helpers.mkroundedrect(),
    bar_shape = helpers.mkroundedrect(),
    clip      = true,
    widget    = wibox.widget.progressbar
}

local function ctrl_buts(icon, action)
    return wibox.widget {
        text   = icon,
        font   = ic_font .. dash_size / 48,
        widget = wibox.widget.textbox,
        buttons = {
            awful.button({}, 1, function(action)
                action() end)
        }
    }
end
local ctrl_play = ctrl_buts("") -- , playerctl:play_pause())
local ctrl_prev = ctrl_buts("") -- , playerctl:previous())
local ctrl_next = ctrl_buts("") -- , playerctl:next())

-- Signals
----------
playerctl:connect_signal("metadata",
    function(_, title, artist, album_path, album, new, player_name)
        album_art.image   = album_path
        sng_title.markup  = title
        sng_artist.markup = artist
        sng_album.markup  = album
end)
playerctl:connect_signal("position",
    function(_, interval_sec, length_sec, player_name)
        sng_progress.max_value = length_sec
        sng_progress.value     = interval_sec
end)
playerctl:connect_signal("playback_status",
    function(_, playing, player_name)
        ctrl_play.text = playing and "" or ""
end)

-- Music Player
---------------
local function music()
    return wibox.widget {
        {
            {
                {
                    {
                        {
                            sng_title,
                            step_function = wibox.container.scroll.
                                            step_functions.linear_increase,
                            layout = wibox.container.scroll.horizontal
                        },
                        {
                            sng_artist,
                            step_function = wibox.container.scroll.
                                            step_functions.linear_increase,
                            layout = wibox.container.scroll.horizontal
                        },
                        {
                            sng_album,
                            step_function = wibox.container.scroll.
                                            step_functions.linear_increase,
                            layout = wibox.container.scroll.horizontal
                        },
                        layout = wibox.layout.fixed.vertical
                    },
                    halign = "left",
                    valign = "center",
                    layout = wibox.container.place
                },
                {
                    ctrl_prev,
                    ctrl_play,
                    ctrl_next,
                    spacing = dash_size / 96,
                    layout  = wibox.layout.fixed.horizontal
                },
                layout = wibox.layout.fixed.vertical
            },
            margins = dash_size / 72,
            widget  = wibox.container.margin
        },
        {
            sng_progress,
            valign = "bottom",
            layout = wibox.container.place
        },
        album_art,
        layout = wibox.container.stack
    }
end
return music
