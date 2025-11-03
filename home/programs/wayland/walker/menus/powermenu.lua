Name = "powermenu"
NamePretty = "Powermenu"
Icon = "system-shutdown-symbolic"

function GetEntries()
    local logout_cmds = {
        ["plasma"] = "qdbus org.kde.Shutdown /Shutdown logout",
        ["niri"] = "niri msg action quit",
        ["hyprland"] = "hyprctl dispatch exit",
    }

    local desktop = string.lower(os.getenv("XDG_SESSION_DESKTOP") or "")
    return {
        {
            Text = "Poweroff",
            Actions = {
                poweroff = logout_cmds[desktop] .. "&& systemctl poweroff",
            },
            Icon = "system-shutdown-symbolic",
        },
        {
            Text = "Reboot",
            Actions = {
                reboot = logout_cmds[desktop] .. "&& systemctl reboot",
            },
            Icon = "system-reboot-symbolic",
        },
        {
            Text = "Hibernate",
            Actions = {
                hibernate = "systemctl hibernate",
            },
            Icon = "system-hibernate-symbolic",
        },
        {
            Text = "Suspend",
            Actions = {
                hibernate = "systemctl suspend",
            },
            Icon = "system-suspend-symbolic",
        },
        {
            Text = "Lock",
            Actions = {
                lock = "loginctl lock-session",
            },
            Icon = "system-lock-screen-symbolic",
        },
        {
            Text = "Logout",
            Actions = {
                logout = logout_cmds[desktop],
            },
            Icon = "application-exit-symbolic",
        },
    }
end
