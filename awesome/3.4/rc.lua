--  rc.lua
-- Quentin MARY


-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require("beautiful")
require("naughty")
require("freedesktop.utils")
require("freedesktop.menu")
require("freedesktop.desktop")

local calendar2 = require("calendar2")
local vicious = require("vicious")
local keydoc = require("keydoc")

-- {{{ Error handling
require("rc/errors")
-- }}}

-- {{{ Variable definitions
require("rc/appearance")

terminal = "urxvt"
editor = os.getenv("EDITOR") or os.getenv("VISUAL") or "vi"
editor_cmd = terminal .. " -e " .. editor

freedesktop.utils.terminal = terminal
freedesktop.utils.icon_theme = 'gnome'

modkey = "Mod4"

layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.fair,
    awful.layout.suit.max,
    awful.layout.suit.magnifier
}

require("rc/tags")
-- }}}


-- {{{ Menu
require("rc/menu")
-- }}}


   -- desktop icons
   for s = 1, screen.count() do
      freedesktop.desktop.add_applications_icons({screen = s, showlabels = true})
      freedesktop.desktop.add_dirs_and_files_icons({screen = s, showlabels = true})
   end


-- {{{ Wibox
require("rc/wibox")
-- }}}


-- {{{ Key bindings
require("rc/bindings")
root.keys(globalkeys)
-- }}}


-- {{{ Rules
require("rc/rules")
-- }}}

-- {{{ Signals
require("rc/signals")
-- }}}

-- {{{ Autostart conf
require("rc/autostart")
-- }}}

 awful.hooks.timer.register(10, function () volume("update", tb_volume) end)
