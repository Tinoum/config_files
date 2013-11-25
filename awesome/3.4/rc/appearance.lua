-- Themes define colours, icons, and wallpapers
-- Use personal theme if existing else goto default
do
    local user_theme, ut
    user_theme = awful.util.getdir("config") .. "/themes/brown/theme.lua"
    ut = io.open(user_theme)
    if ut then
        io.close(ut)
        beautiful.init(user_theme)
    else
        print("Theme doesn't exist, falling back to opeSUSE")
        beautiful.init("/usr/share/awesome/themes/openSUSE/theme.lua")
    end
end

-- beautiful.init("/usr/share/awesome/themes/openSUSE/theme.lua")
