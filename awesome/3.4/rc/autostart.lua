-- {{{ Autostart conf
awful.util.spawn_with_shell("~/bin/startup.sh --restart")
awful.util.spawn_with_shell("mpd")
awful.util.spawn_with_shell("xscreensaver")
awful.util.spawn_with_shell("xcompmgr -c -C -t-5 -l-5 -r4.2 -o.55 &")
--awful.util.spawn_with_shell("xcompmgr &")
-- }}}
