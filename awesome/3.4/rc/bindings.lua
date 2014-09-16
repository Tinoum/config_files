local keydoc = require("keydoc")

-- these are needed by the keydoc a better solution would be to place them in theme.lua
-- but leaving them here also provides a mean to change the colors here ;)

   beautiful.fg_widget_value="blue"
   beautiful.fg_widget_clock="black"
   beautiful.fg_widget_value_important="red"



-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    -- Perso
    keydoc.group("Bindings Perso"),
    awful.key({ modkey,           }, "l",    function () awful.util.spawn("xscreensaver-command -activate") end,"Lock Screen"),
    awful.key({ modkey,           }, "/",    function () awful.util.spawn("mpc pause") end,"Pause MPD"),
    awful.key({ modkey, "Shift"   }, "/",    function () awful.util.spawn("mpc play") end,"Play/Resume MPD"),
    awful.key({ modkey, "Shift"   }, ".",    function () awful.util.spawn("mpc next") end,"Play Next MPD Track"),
    awful.key({ modkey, "Shift"   }, ",",    function () awful.util.spawn("mpc prev") end,"Play Previous MPD Track"),
    awful.key({ modkey,           }, ",",    function () awful.util.spawn("mpc volume -5") end,"Decrease Volume by 5%"),
    awful.key({ modkey,           }, ".",    function () awful.util.spawn("mpc volume +5") end,"Increase Volume by 5%"),
   awful.key({ modkey }, "b",          function () awful.client.incmwfact( 0.05) end, "Decrease client vertical size"),
   awful.key({ modkey }, "v",          function () awful.client.incmwfact(-0.05) end, "Increase client vertical size"),
   awful.key({ modkey, "Shift" }, "b",          function () awful.tag.incmwfact( 0.05) end, "Decrease window vertical size"),
   awful.key({ modkey, "Shift" }, "v",          function () awful.tag.incmwfact(-0.05) end, "Increase window vertical size"),

   keydoc.group("Global Keys"),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,"Previous Tag" ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,"Next tag" ),
    awful.key({ modkey, "Shift"   }, "Left", function()  awful.screen.focus(1) end),
    awful.key({ modkey, "Shift"   }, "Right", function() awful.screen.focus(2) end),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,"Clear Choice"),
    awful.key({modkey,}, "F1",keydoc.display,"Display Keymap Menu"),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end,"Raise focus"),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end,"Lower focus"),
    awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end,"Show menu"),

    -- Layout manipulation
    keydoc.group("Layout manipulation"),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,"Swap with next window"),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,"Swap with previous window "),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,"Relative focus increase" ),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,"Relative focus decrease"),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,"Jump to window "),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,"Cycle windows or windows style"),


    -- Standard program
    keydoc.group("Standard Programs"),
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end,"Open terminal"),
    awful.key({ modkey, "Control" }, "r", awesome.restart,"Restart awesome"),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,"Quit awesome"),

    awful.key({ modkey,           }, ";",     function () awful.tag.incmwfact( 0.05)    end,"Increase window size"),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end,"Decrease window size"),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end,"Increase master"),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end,"Decrease master"),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end,"Increase column"),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end,"Decrease column"),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end,"Cycle layout style forward"),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end,"Cycle layout style reverse"),

    awful.key({ modkey, "Control" }, "n", awful.client.restore,"Client restore"),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end,"Run command"),
    -- this function below will enable ssh login as long as the remote host is defined in $HOME/.ssh/config
    -- else by give the remote host name at the prompt which will also work
    awful.key({ modkey,           }, "s",
              function ()
                  awful.prompt.run({ prompt = "ssh: " },
                  mypromptbox[mouse.screen].widget,
                  function(h) awful.util.spawn(terminal .. " -e slogin " .. h) end,
                  function(cmd, cur_pos, ncomp)
                      -- get hosts and hostnames
                      local hosts = {}
                      f = io.popen("sed 's/#.*//;/[ \\t]*Host\\(Name\\)\\?[ \\t]\\+/!d;s///;/[*?]/d' " .. os.getenv("HOME") .. "/.ssh/config | sort")
                      for host in f:lines() do
                          table.insert(hosts, host)
                      end
                      f:close()
                      -- abort completion under certain circumstances
                      if cur_pos ~= #cmd + 1 and cmd:sub(cur_pos, cur_pos) ~= " " then
                          return cmd, cur_pos
                      end
                      -- match
                      local matches = {}
                      table.foreach(hosts, function(x)
                          if hosts[x]:find("^" .. cmd:sub(1, cur_pos):gsub('[-]', '[-]')) then
                              table.insert(matches, hosts[x])
                          end
                      end)
                      -- if there are no matches
                      if #matches == 0 then
                          return cmd, cur_pos
                      end
                      -- cycle
                      while ncomp > #matches do
                          ncomp = ncomp - #matches
                      end
                      -- return match and position
                      return matches[ncomp], #matches[ncomp] + 1
                  end,
                  awful.util.getdir("cache") .. "/ssh_history")
              end,"SSH login"),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end,"Run lua command")
)

clientkeys = awful.util.table.join(
   keydoc.group("Window management"),
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end,"Toggle fullscreen"),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,"Kill window"),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle,"Toggle floating"    ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,"Swap to master"),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen,"Move to screen" ),
    awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw() end,"redraw window"),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,"Minimize client"),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end,"Maximize client")
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))


