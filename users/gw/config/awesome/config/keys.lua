--------------
-- Keybinds --
--------------

-- Imports
local gears     = require('gears')
local awful     = require('awful')
local beautiful = require('beautiful')

local playerctl = require('modules.bling').signal.playerctl.lib()

local menu      = require('ui.menu')
require('awful.autofocus') -- don't remove this, trust me

modkey       = "Mod4"

-- Enable sloppy focus, so that focus follows mouse.
--[[ client.connect_signal("mouse::enter", function(c) ]]
--[[     c:activate { context = "mouse_enter", raise = false } ]]
--[[ end) ]]

-- Root Window mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () menu.mainmenu:toggle() end),
})

-- Global key/mouse bindings
awful.keyboard.append_global_keybindings({
    -- Utils
    --------
    -- Reload Awesome
    awful.key({ modkey, "Control" }, "r",           awesome.restart),
    -- Term
    awful.key({ modkey,           }, "Return",      function() awful.spawn(terminal) end),
    -- Editor
    awful.key({ modkey, "Shift"   }, "Return",      function() awful.spawn(editor_cmd) end),
    -- File Browsers (term, gui)
    awful.key({ modkey,           }, "e",           function() awful.spawn(files_cmd) end),
    awful.key({ modkey, "Shift"   }, "e",           function() awful.spawn(files_gui) end),
    -- Task Manager
    awful.key({ modkey,           }, "Escape",      function() awful.spawn(tasks_cmd) end),
    -- Awesome Menu
    awful.key({ modkey,           }, "w",           function() mymainmenu:show() end),
    -- Application launcher
    awful.key({ modkey            }, "p",           function() awful.spawn(app_launcher) end),

    -- Window Management
    --------------------
    -- switch focus (next, previous)
    awful.key({ modkey,           }, "j",           function() awful.client.focus.byidx( 1) end),
    awful.key({ modkey,           }, "k",           function() awful.client.focus.byidx(-1) end),
    -- swap windows (next, previous)
    awful.key({ modkey, "Shift"   }, "j",           function() awful.client.swap.byidx(  1) end),
    awful.key({ modkey, "Shift"   }, "k",           function() awful.client.swap.byidx( -1) end),
    -- switch focused monitor (next, previous)
    awful.key({ modkey,           }, "period",      function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey,           }, "comma",       function () awful.screen.focus_relative(-1) end),

    -- Layout Management
    --------------------
    -- master size (grow, shrink)
    awful.key({ modkey,           }, "l",           function() awful.tag.incmwfact( 0.05) end),
    awful.key({ modkey,           }, "h",           function() awful.tag.incmwfact(-0.05) end),
    -- master amount (grow, shrink)
    awful.key({ modkey,           }, "equal",       function() awful.tag.incnmaster( 1, nil, true) end),
    awful.key({ modkey,           }, "minus",       function() awful.tag.incnmaster(-1, nil, true) end),
    -- slaves size (grow, shrink)
    awful.key({ modkey, "Shift"   }, "l",           function() awful.client.incwfact( 0.05) end),
    awful.key({ modkey, "Shift"   }, "h",           function() awful.client.incwfact(-0.05) end),
    -- column amount (grow, shrink)
    awful.key({ modkey, "Shift"   }, "equal",       function() awful.tag.incncol( 1, nil, true) end),
    awful.key({ modkey, "Shift"   }, "minus",       function() awful.tag.incncol(-1, nil, true) end),
    -- cycle layouts (next, previous)
    awful.key({ modkey,           }, "space",       function() awful.layout.inc( 1) end),
    awful.key({ modkey, "Shift"   }, "space",       function() awful.layout.inc(-1) end),

    -- Media
    --------
    -- screenshot (selection, screen)
    awful.key({ nil,              }, "Print",       function() awful.spawn.with_shell('scsScript sel')  end),
    awful.key({ modkey,           }, "Print",       function() awful.spawn.with_shell('scsScript scr')  end),
    -- system volume (up, down, mute)
    awful.key({ nil,           }, "XF86AudioRaiseVolume", function() awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+') end),
    awful.key({ nil,           }, "XF86AudioLowerVolume", function() awful.spawn('wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-') end),
    awful.key({ nil,           }, "XF86AudioMute",        function() awful.spawn('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle') end),
    -- song volume (up, down)
    awful.key({ nil, "Alt"     }, "XF86AudioRaiseVolume", function() playerctl:set_volume('0.05+')              end),
    awful.key({ nil, "Alt"     }, "XF86AudioLowerVolume", function() playerctl:set_volume('0.05-')              end),
    -- song playback (play, prev, next)
    awful.key({ nil,           }, "XF86AudioPlay",  function() playerctl:play_pause()                   end),
    awful.key({ nil,           }, "XF86AudioPrev",  function() playerctl:previous()                     end),
    awful.key({ nil,           }, "XF86AudioNext",  function() playerctl:next()                         end),
    -- language
    awful.key({ modkey,           }, "u",           function() awesome.emit_signal("signal::lang")      end),
    -- brightness (up, down)
    awful.key({ nil,    }, "XF86MonBrightnessUp",   function() awful.spawn('brightnessctl -d intel_backlight set 5%+') end),
    awful.key({ nil,    }, "XF86MonBrightnessDown", function() awful.spawn('brightnessctl -d intel_backlight set 5%-') end),

    -- UI
    -----
    -- toggle dashboard
    awful.key({ modkey,           }, "d",           function() awesome.emit_signal("widget::dashboard") end),
    -- toggle bar
    awful.key({ modkey,           }, "b",           function() awesome.emit_signal("widget::bar")       end),
})
awful.keyboard.append_global_keybindings({
    -- Switch to tag
    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "only view tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },
    -- Show tag
    awful.key {
        modifiers   = { modkey, "Control" },
        keygroup    = "numrow",
        description = "toggle tag",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                awful.tag.viewtoggle(tag)
            end
        end,
    },
    -- Send to tag
    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "move focused client to tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
    -- Show focused on tag
    awful.key {
        modifiers   = { modkey, "Control", "Shift" },
        keygroup    = "numrow",
        description = "toggle focused client on tag",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:toggle_tag(tag)
                end
            end
        end,
    },
})
-- CLient key/mouse binds
client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)
client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        -- toggle state (fullscreen, maximized, floating, sticky)
        awful.key({ modkey,           }, "f",      function(c) c.fullscreen = not c.fullscreen c:raise() end),
        awful.key({ modkey,           }, "m",      function(c) c.maximized = not c.maximized c:raise() end),
        awful.key({ modkey,           }, "s",      awful.client.floating.toggle),
        awful.key({ modkey, "Shift"   }, "s",      function(c) c.sticky = not c.sticky end),
        -- default close window behaviour
        awful.key({ modkey,           }, "q",      function(c) c:kill() end),
        -- kill window
        --[[ awful.key({ modkey,           }, "q",      function(c) awful.spawn("kill -9 " .. c.pid) end), ]]
        -- send to master
        awful.key({ modkey,           }, "Tab",    function(c) c:swap(awful.client.getmaster()) end),
    })
end)
