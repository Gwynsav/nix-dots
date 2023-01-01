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
    vertical_fit_policy   = "fit",
    horizontal_fit_policy = "fit",
    resize        = true,
    opacity       = 0.33,
    align         = "center",
    clip_shape    = helpers.mkroundedrect(),
    forced_height = dash_size * 0.2,
    forced_width  = dash_size * 0.4,
    widget        = wibox.widget.imagebox
}

local function sng_info(default, size)
    return wibox.widget {
        markup = default,
        font   = ui_font .. dash_size / size,
        widget = wibox.widget.textbox
    }
end
local sng_title  = sng_info("<b>Nothing Playing</b>", 40)
local sng_artist = sng_info("by <i>Unknown</i>",      60)
local sng_album  = sng_info("on <i>Untitled</i>",     60)

local sng_progress = wibox.widget {
    color     = beautiful.grn,
    background_color = beautiful.lbg,
    shape     = helpers.mkroundedrect(),
    bar_shape = helpers.mkroundedrect(),
    forced_height = dash_size / 100,
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
local ctrl_next = ctrl_buts("") -- , playerctl:next())

-- Signals
----------
playerctl:connect_signal("metadata",
    function(_, title, artist, album_path, album, new, player_name)
        album_art.image   = album_path:match("/") and album_path or user_avatar
        sng_title.markup  = title:match("%w") and "<b>" .. title .. "</b>" or "<b>Nothing Playing</b>"
        sng_artist.markup = artist:match("%w") and "by " .. artist or "by Unknown"
        sng_album.markup  = album:match("%w") and"on <i>" .. album .. "</i>" or "on <i>Unknown</i>"
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
        album_art,
        {
            {
                {
                    {
                        {
                            {
                                sng_title,
                                step_function = wibox.container.scroll.step_functions.
                                                waiting_nonlinear_back_and_forth,
                                speed         = 100,
                                rate          = 144,
                                layout = wibox.container.scroll.horizontal
                            },
                            {
                                sng_artist,
                                step_function = wibox.container.scroll.step_functions.
                                                waiting_nonlinear_back_and_forth,
                                speed         = 100,
                                rate          = 144,
                                layout = wibox.container.scroll.horizontal
                            },
                            {
                                sng_album,
                                step_function = wibox.container.scroll.step_functions.
                                                waiting_nonlinear_back_and_forth,
                                speed         = 100,
                                rate          = 144,
                                layout = wibox.container.scroll.horizontal
                            },
                            layout = wibox.layout.fixed.vertical
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
                    valign = "center",
                    halign = "left",
                    layout = wibox.container.place
                },
                margins = {
                    left   = dash_size / 72,
                    right  = dash_size / 72,
                    top    = dash_size / 48,
                },
                widget  = wibox.container.margin
            },
            {
                sng_progress,
                valign = "bottom",
                layout = wibox.container.place
            },
            layout = wibox.layout.align.vertical
        },
        layout = wibox.layout.stack
    }
end
return music
