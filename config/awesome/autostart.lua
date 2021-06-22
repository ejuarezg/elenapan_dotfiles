-- Adapted from https://github.com/Mofiqul/awesome-shell/blob/main/module/autostart.lua

local awful = require("awful")
local filesystem = require("gears.filesystem")
local naughty = require("naughty")
local startup_apps = {
    -- Add your startup programs here
    -- "picom -b --experimental-backends --config ~/.config/picom/picom.conf",
    "redshift -t 6500:3500 -l " .. os.getenv("GEOLOCATION"),
    -- "udiskie",
    -- "xidlehook --not-when-fullscreen --not-when-audio  --timer 300 'light -S 1' 'light -S 50' --timer 60 'light -S 50;" ..default_apps.lock_screen .." ' '' --timer 900 'systemctl suspend'  ''",
    "light -S 50",
    "pgrep polkitd || /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
}


local spawn_once = function (cmd)
    local findme = cmd
    local firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.easy_async_with_shell(
        string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd),
        function(_, stderr)
            if not stderr or stderr == '' then
                return
            end
            naughty.notification({
                app_name = 'Startup Applications',
                title = "Error starting application",
                message = "Error while starting " .. cmd,
                timeout = 10,
                urgency = "critical",
            })
        end
    )
end

for _, app in ipairs(startup_apps) do
    spawn_once(app)
end
