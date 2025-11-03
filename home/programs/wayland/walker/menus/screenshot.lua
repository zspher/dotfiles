Name = "screenshot"
NamePretty = "Screenshot"
Icon = "accessories-screenshot-symbolic"

function GetEntries()
    local time = os.date("%Y-%m-%dT%X")
    local path = "~/Pictures/Screenshots/" .. time .. ".png"
    return {
        {
            Text = "Capture Fullscreen",
            Actions = {
                capture = "grimblast copysave screen -n " .. path,
            },
            Icon = "view-fullscreen-symbolic",
        },
        {
            Text = "Capture Area",
            Actions = {
                capture = "grimblast copysave area -f -n " .. path,
            },
            Icon = "image-crop-symbolic",
        },
        {
            Text = "Capture Window",
            Actions = {
                capture = "grimblast copysave active -n " .. path,
            },
            Icon = "window-symbolic",
        },
        {
            Text = "Capture Fullscreen in 5s",
            Actions = {
                capture = "grimblast copysave screen -w 5 -n " .. path,
            },
            Icon = "timer-symbolic",
        },
    }
end
