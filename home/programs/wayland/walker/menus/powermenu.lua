Name = "powermenu"
NamePretty = "powermenu"
Icon = "applications-other"

function GetEntries()
    local logout_cmds = {
        ["plasma"] = "qdbus org.kde.Shutdown /Shutdown logout",
        ["niri"] = "niri msg action quit",
        ["hyprland"] = "hyprctl dispatch exit",
    }

    local desktop = string.lower(os.getenv("XDG_SESSION_DESKTOP") or "")
    local entries = {
        {
            Text = "Poweroff",
            Actions = {
                poweroff = "systemctl poweroff",
            },
            Icon = "system-shutdown-symbolic",
        },
        {
            Text = "Reboot",
            Actions = {
                reboot = "systemctl reboot",
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

    return entries
end
