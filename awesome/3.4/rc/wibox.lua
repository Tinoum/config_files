local calendar2 = require("calendar2")
local vicious = require("vicious")

-- {{{ Wibox
-- We need spacer and separator between the widgets
spacer = widget({type = "textbox"})
separator = widget({type = "textbox"})
spacer.text = " "
separator.text = "|"


-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

calendar2.addCalendarToWidget(mytextclock, "<span color='green'>%s</span>")


mycpuwidget = widget({ type = "textbox" })
vicious.register(mycpuwidget, vicious.widgets.cpu, "$1%")

-- Weather widget
--myweatherwidget = widget({ type = "textbox" })
--weather_t = awful.tooltip({ objects = { myweatherwidget },})
--vicious.register(myweatherwidget, vicious.widgets.weather,
--                function (widget, args)
--                    weather_t:set_text("City: " .. args["{city}"] .."\nWind: " .. args["{windkmh}"] .. "km/h " .. args["{wind}"] .. "\nSky: " .. args["{sky}"] .. "\nHumidity: " .. args["{humid}"] .. "%")
--                    return args["{tempc}"] .. "C"
--                end, 1800, "EDDN")
                --'1800': check every 30 minutes.
                --'EDDN': Nuernberg ICAO code.


-- Create MPD widget
--mpdwidget = widget({ type = "textbox" })
--vicious.register(mpdwidget, vicious.widgets.mpd,
--    function (widget, args)
--        if args["{state}"] == "Stop" then
--            return " - "
--        else
--            return args["{Artist}"]..' - '.. args["{Album}"]..' - '.. args["{Title}"]..' ('
--        end
--    end, 10)



-- Create a systray
mysystray = widget({ type = "systray" })

-- Create Awesompd widget
  require('awesompd/awesompd')

  musicwidget = awesompd:create() -- Create awesompd widget
  musicwidget.font = "Liberation Mono" -- Set widget font 
  musicwidget.font_color = "white"      --Set widget font color
  musicwidget.background = "green"      --Set widget background
  musicwidget.scrolling = true -- If true, the text in the widget will be scrolled
  musicwidget.output_size = 300 -- Set the size of widget in symbols
  musicwidget.update_interval = 1 -- Set the update interval in seconds

  -- Set the folder where icons are located (change username to your login name)
  musicwidget.path_to_icons = "/home/quentin/.config/awesome/icons"

  -- Set the default music format for Jamendo streams. You can change
  -- this option on the fly in awesompd itself.
  -- possible formats: awesompd.FORMAT_MP3, awesompd.FORMAT_OGG
  musicwidget.jamendo_format = awesompd.FORMAT_MP3

  -- Specify the browser you use so awesompd can open links from
  -- Jamendo in it.
  musicwidget.browser = "firefox"

  -- If true, song notifications for Jamendo tracks and local tracks
  -- will also contain album cover image.
  musicwidget.show_album_cover = true

  -- Specify how big in pixels should an album cover be. Maximum value
  -- is 100.
  musicwidget.album_cover_size = 50

  -- This option is necessary if you want the album covers to be shown
  -- for your local tracks.
  musicwidget.mpd_config = "/home/quentin/.mpdconf"

  -- Specify decorators on the left and the right side of the
  -- widget. Or just leave empty strings if you decorate the widget
  -- from outside.
  musicwidget.ldecorator = " "
  musicwidget.rdecorator = " "

  -- Set all the servers to work with (here can be any servers you use)
  musicwidget.servers = {
     { server = "localhost",
          port = 6600 },
     --{ server = "192.168.0.72",
          --port = 6600 }
  }

  -- Set the buttons of the widget. Keyboard keys are working in the
  -- entire Awesome environment. Also look at the line 352.
  musicwidget:register_buttons({
                            -- { "", awesompd.MOUSE_LEFT, musicwidget:command_playpause() },
                               { "Control", awesompd.MOUSE_SCROLL_UP, musicwidget:command_prev_track() },
                               { "Control", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_next_track() },
                              -- { "", awesompd.MOUSE_SCROLL_UP, musicwidget:command_volume_up() },
                              -- { "", awesompd.MOUSE_SCROLL_DOWN, musicwidget:command_volume_down() },
                               { "", awesompd.MOUSE_RIGHT, musicwidget:command_show_menu() },
                              -- { "", "XF86AudioLowerVolume", musicwidget:command_volume_down() },
                              -- { "", "XF86AudioRaiseVolume", musicwidget:command_volume_up() },
                              -- { modkey, "Pause", musicwidget:command_playpause() } 
                              })

--  musicwidget:run() -- After all configuration is done, run the widget

-- Create volume widget
cardid  = 0
 channel = "Master"
 function volume (mode, widget)
 	if mode == "update" then
              local fd = io.popen("amixer -c " .. cardid .. " -- sget " .. channel)
              local status = fd:read("*all")
              fd:close()
 		
 		local volume = string.match(status, "(%d?%d?%d)%%")
 		volume = string.format("% 3d", volume)
 
 		status = string.match(status, "%[(o[^%]]*)%]")
 
 		if string.find(status, "on", 1, true) then
 			volume = volume .. "%"
 		else
 			volume = volume .. "M"
 		end
 		widget.text = volume
 	elseif mode == "up" then
 		io.popen("amixer -q -c " .. cardid .. " sset " .. channel .. " 5%+"):read("*all")
 		volume("update", widget)
 	elseif mode == "down" then
 		io.popen("amixer -q -c " .. cardid .. " sset " .. channel .. " 5%-"):read("*all")
 		volume("update", widget)
 	else
 		io.popen("amixer -c " .. cardid .. " sset " .. channel .. " toggle"):read("*all")
 		volume("update", widget)
 	end
 end

 tb_volume = widget({ type = "textbox", name = "tb_volume", align = "right" })
 tb_volume.buttons = ({
 	button({ }, 4, function () volume("up", tb_volume) end),
 	button({ }, 5, function () volume("down", tb_volume) end),
 	button({ }, 1, function () volume("mute", tb_volume) end)
 })
 volume("update", tb_volume)

-- Create a wibox for each screen and add it
mywibox = {}
mywibox_bottom = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, awful.tag.viewnext),
                    awful.button({ }, 5, awful.tag.viewprev)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))
for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(function(c)
                                              return awful.widget.tasklist.label.currenttags(c, s)
                                          end, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })
    mywibox_bottom[s] = awful.wibox({ position = "bottom", screen = s, ontop = false, width = 1, height = 16 })
    --mywibox_bottom[s] = awful.wibox({ position = "bottom", screen = s })

    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
	--mytasklist[s],
	mylayoutbox[s],
	mytextclock,
--        tb_volume,
        s == 1 and mysystray or nil,
        layout = awful.widget.layout.horizontal.rightleft
    }

--    mywibox_bottom[s].widgets = {
--        musicwidget.widget,
--        layout = awful.widget.layout.horizontal.rightleft
--    }

end
-- }}}

