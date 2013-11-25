tags = {
       names = { "OK", "test"},
       layout = { layouts[1], layouts[2]} }

for s = 1, screen.count() do
    tags[s] = awful.tag(tags.names, s, tags.layout)
end

