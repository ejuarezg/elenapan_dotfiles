-- Adapted from https://github.com/Mofiqul/awesome-shell/blob/main/module/autostart.lua

local awful = require("awful")
local filesystem = require("gears.filesystem")
local naughty = require("naughty")
local startup_apps = {
    -- Add your startup programs here
    -- "picom -b --experimental-backends --config ~/.config/picom/picom.conf",
    "redshift -t 6500:3500 -l " .. os.getenv("GEOLOCATION"),
    -- "udiskie",
    -- Note: 3600 seconds is 1 hour
    "xidlehook --not-when-fullscreen --not-when-audio --timer 900 'light -S 1' 'light -S 50' --timer 15 'light -S 50; awesome-client \"lock_screen_show()\"' '' --timer 14400 'systemctl suspend' ''",
    "light -S 50",
    "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
    "xset s off -dpms",
}


local spawn_once = function (cmd)
    local findme = cmd

    local firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace - 1)
    end

    -- Find the command when given an absolute path
    local lastslash = findme:find("/[^/]*$")
    if lastslash then
        -- NOTE pgrep only cares about the first 15 characters of a command
        findme = findme:sub(lastslash + 1, lastslash + 15)
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
