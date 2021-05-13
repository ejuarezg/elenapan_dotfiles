-- Provides:
-- evil::volume
--      percentage (integer)
--      muted (boolean)
local awful = require("awful")

local volume_old = -1
local muted_old = -1
local function emit_volume_info()
    -- Get volume info of the Master ALSA mixer.
    -- The lines starting with "Front Left:" or "Front Right:"
    -- contain the volume level and muted state.
    -- We `grep` the front left channel and assume the other
    -- channels have the same volume level.
    awful.spawn.easy_async_with_shell("amixer sget Master | grep 'Front Left:'", function(stdout)
        local volume = stdout:match('(%d+)%%')
        local muted = stdout:match('%[off%]')
        local muted_int = muted and 1 or 0
        local volume_int = tonumber(volume)
        -- Only send signal if there was a change
        -- We need this since we use `pactl subscribe` to detect
        -- volume events. These are not only triggered when the
        -- user adjusts the volume through a keybind, but also
        -- through `pavucontrol` or even without user intervention,
        -- when a media file starts playing.
        if volume_int ~= volume_old or muted_int ~= muted_old then
            awesome.emit_signal("evil::volume", volume_int, muted)
            volume_old = volume_int
            muted_old = muted_int
        end
    end)
end

-- Run once to initialize widgets
emit_volume_info()

-- Sleeps until pactl detects an event (volume up/down/toggle mute)
local volume_script = [[
    bash -c "
    LANG=C pactl subscribe 2> /dev/null | grep --line-buffered \"Event 'change' on sink #\"
    "]]


-- Kill old pactl subscribe processes
awful.spawn.easy_async({"pkill", "--full", "--uid", os.getenv("USER"), "^pactl subscribe"}, function ()
    -- Run emit_volume_info() with each line printed
    awful.spawn.with_line_callback(volume_script, {
        stdout = function(line)
            emit_volume_info()
        end
    })
end)


