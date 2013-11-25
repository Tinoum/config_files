-- {{{ Menu
-- Create a laucher widget and a main menu

  mysystem_menu = {
      { 'Lock Screen',     'xscreensaver-command -lock', freedesktop.utils.lookup_icon({ icon = 'system-lock-screen'        }) },
      { 'Logout',           awesome.quit,                freedesktop.utils.lookup_icon({ icon = 'system-log-out'            }) },
      { 'Reboot System',   'xdg-su -c "shutdown -r now"',   freedesktop.utils.lookup_icon({ icon = 'reboot-notifier'           }) },
      { 'Shutdown System', 'xdg-su -c "shutdown -h now"',   freedesktop.utils.lookup_icon({ icon = 'system-shutdown'           }) }
   }

  myawesome_menu = {
     { 'Restart Awesome', awesome.restart,              freedesktop.utils.lookup_icon({ icon = 'gtk-refresh'               }) },
     { "Edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua", freedesktop.utils.lookup_icon({ icon = 'package_settings' }) },
     { "manual", terminal .. " -e man awesome" }
  }

top_menu = {
      { 'Applications', freedesktop.menu.new(),          freedesktop.utils.lookup_icon({ icon = 'start-here'                }) },
      { 'Awesome',      myawesome_menu,                    beautiful.awesome_icon },
      { 'System',       mysystem_menu,                     freedesktop.utils.lookup_icon({ icon = 'system'                    }) },
      { 'Terminal',     freedesktop.utils.terminal,      freedesktop.utils.lookup_icon({ icon = 'terminal'                  }) }
   }

mymainmenu = awful.menu.new({ items = top_menu, width = 150 })


mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon), menu = mymainmenu })
-- }}}
