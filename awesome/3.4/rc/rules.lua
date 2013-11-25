-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     size_hints_honor = false,
                     tag = tags[1][1],
                     switchtotag = true,
                     buttons = clientbuttons } },
    -- to fix youtube fullscreen problems if still seeing bottom bar
    -- for chromium change "plugin-container" to "exe"

    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2] ,
        switchtotag = true } },
    { rule = { instance = "msrempart" },
      properties = { tag = tags[1][4],
                     switchtotag = true } },
    { rule = { instance = "msdonjon" },
      properties = { tag = tags[1][5],
                     switchtotag = true } },
    { rule = { instance = "amarok" },
      properties = { tag = tags[1][8],
                     switchtotag = true } },
    { rule = { instance = "gmpc" },
      properties = { tag = tags[1][8],
                     switchtotag = true } },
    { rule = { instance = "urxvt" },
      properties = { tag = tags[1][3],
                     switchtotag = true } },
}
-- }}}

