local tag = require("tag")
--local layouts = require("layouts")

-- Tags configuration

tags = {
        names = { 
                "1: Main", 
                "2: Web", 
                "3: Local", 
                "4: Rempart", 
                "5: Donjon", 
                "6: Misc_1", 
                "7: Misc_2", 
                "8: Music" 
                },
        layout = { 
                 layouts[1], 
                 layouts[4], 
                 layouts[2], 
                 layouts[2], 
                 layouts[2], 
                 layouts[1], 
                 layouts[1], 
                 layouts[4] 
                 }}

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

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

