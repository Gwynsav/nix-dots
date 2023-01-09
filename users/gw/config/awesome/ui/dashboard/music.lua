-----------------------------
-- dashboard: music player --
-----------------------------

-- Imports
----------
local awful     = require('awful')
local wibox     = require('wibox')
local beautiful = require('beautiful')
local gears     = require('gears')
local gfs       = gears.filesystem
local gc        = gears.color

local helpers   = require('helpers')
local playerctl = require('modules.bling').signal.playerctl.lib()

-- Widgets
----------
local album_art = wibox.widget {
    image       = beautiful.player_bg,
    vertical_fit_policy   = "fit",
    horizontal_fit_policy = "fit",
    resize      = true,
    opacity     = 0.33,
    align       = "center",
    forced_height = dash_size * 0.2,
    forced_width  = dash_size * 0.4,
    clip_shape  = helpers.mkroundedrect(),
    widget      = wibox.widget.imagebox
}

local function sng_info(size, color, placeholder)
    return wibox.widget {
        {
            id     = 'text_role',
            markup = placeholder,
            font   = ui_font .. dash_size / size,
            widget = wibox.widget.textbox
        },
        fg     = color,
        widget = wibox.container.background,
        set_markup = function(self, content)
            self:get_children_by_id('text_role')[1].markup = content
        end
    }
end
local sng_title  = sng_info(60, beautiful.fg_normal, "<b>Nothing Playing</b>")
local sng_artist = sng_info(72, beautiful.dfg, "By Unknown")
local sng_album  = sng_info(72, beautiful.dfg, "On <i>Unknown</i>")

local sng_progress = wibox.widget {
    bar_color        = beautiful.lbg,
    bar_active_color = beautiful.cya,
    handle_color     = beautiful.cya,
    handle_shape     = gears.shape.circle,
    bar_shape        = helpers.mkroundedrect(),
    handle_width     = dash_size / 100,
    forced_height    = dash_size / 100,
    minimum          = 0,
    widget           = wibox.widget.slider,
}
sng_progress:connect_signal('property::value', function(_, value)
    playerctl:set_position(value)
end)

-- Playback Controls
local ctrl_play = wibox.widget {
    text   = "",
    font   = ic_font .. dash_size / 48,
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:play_pause() end)
    }
}
local ctrl_prev = wibox.widget {
    text   = "",
    font   = ic_font .. dash_size / 48,
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:previous() end)
    }
}
local ctrl_next = wibox.widget {
    text   = "",
    font   = ic_font .. dash_size / 48,
    widget = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:next() end)
    }
}
local icon_shff = wibox.widget {
    text    = "",
    font    = ic_font .. dash_size / 48,
    widget  = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:cycle_shuffle() end)
    }
}
local ctrl_shff = helpers.mkbtn(icon_shff, beautiful.lbg, beautiful.blk)
local icon_loop = wibox.widget {
    text    = "",
    font    = ic_font .. dash_size / 48,
    widget  = wibox.widget.textbox,
    buttons = {
        awful.button({}, 1, function()
            playerctl:cycle_loop_status() end)
    }
}
local ctrl_loop = helpers.mkbtn(icon_loop, beautiful.lbg, beautiful.blk)

-- Volume control
local is_hovered = false
local vol_bar = wibox.widget {
    {
        {
            {
                id                  = 'slider_role',
                bar_shape           = helpers.mkroundedrect(),
                bar_color           = beautiful.blk,
                bar_active_color    = beautiful.grn,
                handle_color        = beautiful.grn,
                handle_shape        = gears.shape.circle,
                minimum             = 0,
                maximum             = 100,
                handle_width        = dash_size / 64,
                bar_height          = dash_size / 128,
                forced_height       = dash_size / 72,
                widget              = wibox.widget.slider
            },
            direction = "east",
            widget    = wibox.container.rotate
        },
        margins = dash_size / 72,
        widget  = wibox.container.margin
    },
    bg      = beautiful.lbg,
    shape   = helpers.mkroundedrect(),
    widget  = wibox.container.background,
    get_slider = function(self)
        return self:get_children_by_id('slider_role')[1]
    end,
    set_value  = function(self, val)
        self.slider.value = val * 100
    end
}
vol_bar.slider:connect_signal('property::value', function(_, value)
    playerctl:set_volume(value / 100)
end)
vol_bar:connect_signal('mouse::enter', function()
    is_hovered = true
end)
vol_bar:connect_signal('mouse::leave', function()
    is_hovered = false
end)

-- Signals
----------
playerctl:connect_signal("metadata",
    function(_, title, artist, album_path, album, new, player_name)
        album_art.image   = album_path:match("/") and album_path or beautiful.player_bg
        sng_title.markup  = title:match("%w") and "<b>" .. title .. "</b>" or "<b>Nothing Playing</b>"
        sng_artist.markup = artist:match("%w") and "by " .. artist or "by Unknown"
        sng_album.markup  = album:match("%w") and"on <i>" .. album .. "</i>" or "on <i>Unknown</i>"
end)
playerctl:connect_signal("position", function(_, interval_sec, length_sec, player_name)
    if interval_sec > 0 then
        sng_progress.maximum = length_sec
        sng_progress.value   = interval_sec
    end
end)
playerctl:connect_signal("playback_status", function(_, playing, player_name)
        ctrl_play.text = playing and "" or ""
end)
playerctl:connect_signal("shuffle", function(_, shuffle)
        ctrl_shff.fg = shuffle and beautiful.ylw or beautiful.fg_normal
end)
playerctl:connect_signal("loop_status", function(_, loop_status)
    if loop_status:match('none') then
        ctrl_loop.fg    = beautiful.fg_normal
        icon_loop.text  = ""
    elseif loop_status:match('track') then
        ctrl_loop.fg    = beautiful.ylw
        icon_loop.text  = ""
    else
        ctrl_loop.fg    = beautiful.grn
        icon_loop.text  = ""
    end
end)
playerctl:connect_signal("volume", function(_, volume, player_name)
        vol_bar.value  = not is_hovered and volume
end)

-- Music Player
---------------
local function music()
    return wibox.widget {
        {
            vol_bar,
            {
                album_art,
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
                                {
                                    helpers.mkbtn(ctrl_prev, beautiful.lbg, beautiful.blk),
                                    helpers.mkbtn(ctrl_play, beautiful.lbg, beautiful.blk),
                                    helpers.mkbtn(ctrl_next, beautiful.lbg, beautiful.blk),
                                    spacing = dash_size / 96,
                                    layout  = wibox.layout.fixed.horizontal
                                },
                                nil,
                                {
                                    ctrl_shff,
                                    ctrl_loop,
                                    spacing = dash_size / 96,
                                    layout  = wibox.layout.fixed.horizontal
                                },
                                layout  = wibox.layout.align.horizontal
                            },
                            spacing = dash_size / 72,
                            layout  = wibox.layout.fixed.vertical
                        },
                        margins = {
                            left   = dash_size / 72,
                            right  = dash_size / 72,
                            top    = dash_size / 24,
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
            },
            spacing = dash_size / 72,
            layout  = wibox.layout.fixed.horizontal
        },
        forced_height = dash_size * 0.215,
        widget        = wibox.container.background
    }
end
return music
