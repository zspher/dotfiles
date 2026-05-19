local ctp = require "catppuccin"
local apps = require "apps"

-- apps
-- My long comment block {{{
local terminal = apps.terminal or "kitty -1"
local file_manager = apps.file_manager or "dolphin"
local notification_manager = apps.notification_manager or "swaync-client -t -sw"
local screenshot = apps.screenshot or "~/.config/rofi/bin/screenshot.sh"
local runner = apps.runner or "rofi -show combi"
local clipboard_manager = apps.clipboard_manager
  or "rofi -modes clipboard:cliphist-rofi-img -show clipboard"
local power_menu = apps.power_menu or "~/.config/rofi/bin/powermenu.sh"

hl.bind("CTRL+SHIFT+escape", hl.dsp.exec_cmd(terminal .. " btop"))
hl.bind("CTRL+ALT+T", hl.dsp.exec_cmd(terminal .. " --class kitty-term"))
hl.bind("ALT+SPACE", hl.dsp.exec_cmd(runner))
hl.bind("SUPER+E", hl.dsp.exec_cmd(file_manager))
hl.bind("SUPER+N", hl.dsp.exec_cmd(notification_manager))
hl.bind("SUPER+SHIFT+S", hl.dsp.exec_cmd(screenshot))
hl.bind("CTRL+ALT+Delete", hl.dsp.exec_cmd(power_menu))
hl.bind("SUPER+P", hl.dsp.exec_cmd("nwg-displays", { float = true }))
hl.bind("SUPER+C", hl.dsp.exec_cmd(clipboard_manager))

-- window control
hl.bind("SUPER+Q", hl.dsp.window.close())
hl.bind("SUPER+SHIFT+Q", hl.dsp.exit())

hl.bind(
  "SUPER+SHIFT+F",
  hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" }
)
hl.bind(
  "SUPER+M",
  hl.dsp.window.fullscreen { mode = "maximized", action = "toggle" }
)
hl.bind("SUPER+F", hl.dsp.window.float())
hl.bind("SUPER+SHIFT+C", hl.dsp.window.center())
hl.bind("CTRL+ALT+P", function()
  hl.dispatch(hl.dsp.window.float())
  hl.dispatch(hl.dsp.window.pin { action = "toggle" })
end)

hl.bind("SUPER+SHIFT+P", hl.dsp.window.pseudo { action = "toggle" })
hl.bind("SUPER+T", hl.dsp.layout "togglesplit")
hl.bind("SUPER+S", hl.dsp.window.swap { next = {} })

hl.bind("SUPER+A", hl.dsp.workspace.toggle_special "default")
hl.bind("SUPER+SHIFT+A", function()
  local win = hl.get_active_window()
  if win and win.workspace.special then
    hl.dispatch(hl.dsp.window.move { workspace = "e+0" })
  else
    hl.dispatch(hl.dsp.window.move { workspace = "special:default" })
  end
end)

hl.bind("SUPER+G", hl.dsp.group.toggle())
hl.bind("SUPER+I", hl.dsp.group.lock_active())
hl.bind("SUPER+TAB", hl.dsp.group.next())
hl.bind("SUPER+SHIFT+TAB", hl.dsp.group.prev())

for i = 1, 10 do
  local key = i % 10
  hl.bind("SUPER+" .. key, hl.dsp.focus { workspace = i })
  hl.bind("SUPER+SHIFT+" .. key, hl.dsp.window.move { workspace = i })
end

for k, v in pairs { h = "left", j = "up", k = "down", l = "right" } do
  hl.bind("SUPER+" .. k, hl.dsp.focus { direction = v })
  hl.bind(
    "SUPER+SHIFT+" .. k,
    hl.dsp.window.move { direction = v, group_aware = true }
  )
end
hl.bind("SUPER+CTRL+L", hl.dsp.window.move { workspace = "r+1" })
hl.bind("SUPER+CTRL+H", hl.dsp.window.move { workspace = "r-1" })

hl.bind("SUPER+mouse_down", hl.dsp.focus { workspace = "e+1" })
hl.bind("SUPER+mouse_up", hl.dsp.focus { workspace = "e-1" })
hl.bind("SUPER+mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER+mouse:273", hl.dsp.window.resize(), { mouse = true })

-- media control
hl.bind(
  "XF86AudioPlay",
  hl.dsp.exec_cmd "playerctl play-pause",
  { locked = true }
)
hl.bind("XF86AudioStop", hl.dsp.exec_cmd "playerctl stop", { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd "playerctl pause", { locked = true })
hl.bind(
  "XF86AudioPrev",
  hl.dsp.exec_cmd "playerctl previous",
  { locked = true }
)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd "playerctl next", { locked = true })
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
  { locked = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
  { locked = true }
)

hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%+",
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd "wpctl set-volume -l '1.0' @DEFAULT_AUDIO_SINK@ 6%-",
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd "brightnessctl s +5%",
  { locked = true, repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd "brightnessctl s 5%-",
  { locked = true, repeating = true }
)

-- special binds
hl.bind("SUPER+F1", hl.dsp.exec_cmd "keepassxc --lock")

hl.gesture {
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
}

-- submaps
hl.bind("SUPER+R", hl.dsp.submap "resize")
hl.define_submap("resize", function()
  hl.bind(
    "h",
    hl.dsp.window.resize { x = -20, y = 0, relative = true },
    { repeating = true }
  )
  hl.bind(
    "j",
    hl.dsp.window.resize { x = 0, y = -20, relative = true },
    { repeating = true }
  )
  hl.bind(
    "k",
    hl.dsp.window.resize { x = 0, y = 20, relative = true },
    { repeating = true }
  )
  hl.bind(
    "l",
    hl.dsp.window.resize { x = 20, y = 0, relative = true },
    { repeating = true }
  )

  hl.bind("escape", hl.dsp.submap "reset")
end)

-- look and feel
hl.config {
  general = {
    gaps_in = 0,
    gaps_out = 0,
    allow_tearing = true,
    col = {
      active_border = ctp.mauve,
      inactive_border = ctp.mantle,
    },
  },
  decoration = {
    rounding = 10,
    blur = { enabled = false },
    shadow = { enabled = false },
  },

  group = {
    col = {
      border_active = ctp.mauve,
      border_inactive = ctp.surface0,
      border_locked_active = ctp.blue,
      border_locked_inactive = ctp.mantle,
    },

    groupbar = {
      height = 10,
      render_titles = true,
      col = {
        active = ctp.text,
        inactive = ctp.surface0,
        locked_active = ctp.blue,
        locked_inactive = ctp.mantle,
      },
    },
  },
  animations = { enabled = false },

  input = {
    kb_layout = "us",
    touchpad = { natural_scroll = true },
    scroll_method = "on_button_down",
  },
  binds = {
    movefocus_cycles_fullscreen = true,
  },
  xwayland = {
    force_zero_scaling = true,
  },
  misc = {
    force_default_wallpaper = 0,
    anr_missed_pings = 10,
  },
}

-- layout configs
hl.config {
  dwindle = {
    preserve_split = true,
  },
}

hl.env("QT_QPA_PLATFORM", "wayland")

-- startup
hl.on("hyprland.start", function()
  hl.exec_cmd "/nix/store/2r0s13qpds22r2dv2dgqrm73n1780mbf-conditional_startup"
  hl.dsp.focus { monitor = "HDMI-A-1" }

  hl.exec_cmd(
    "dbus-update-activation-environment --systemd"
      .. "DISPLAY"
      .. "HYPRLAND_INSTANCE_SIGNATURE"
      .. "WAYLAND_DISPLAY"
      .. "XDG_CURRENT_DESKTOP"
      .. "QT_QPA_PLATFORM"
  )
  if tonumber(os.date "%H") < 12 then hl.exec_cmd "obsidian" end
end)

-- workspace, window & layer rules
hl.workspace_rule { workspace = "8", monitor = "eDP-1", default = true }

local window_rules = {
  { match = { fullscreen = true }, border_color = ctp.green },
  { match = { float = true }, border_color = ctp.green },
  { match = { float = true }, border_color = ctp.green },
  { match = { pin = true, float = true }, border_color = ctp.yellow },
  {
    match = { xwayland = true, float = false, fullscreen = false },
    border_color = ctp.overlay2,
  },

  { match = { class = "obsidian" }, workspace = "1 silent" },
  { match = { class = "[Bb]rave-browser" }, workspace = "2" },
  { match = { class = "Code" }, workspace = "3" },
  { match = { class = "code-url-handler" }, workspace = "3" },
  { match = { class = "kitty-term" }, workspace = "3" },
  { match = { class = "vesktop" }, workspace = "4 silent" },
  {
    match = { class = "org.keepassxc.KeePassXC" },
    workspace = "9",
    no_screen_share = true,
  },
  { match = { class = "spotify" }, workspace = "10" },
  { match = { class = "about:blank - Brave" }, workspace = "unset" },
  { match = { class = "localhost:.* - Brave" }, workspace = "unset" },

  {
    match = { class = "[Bb]rave-browser", title = "DevTools.*" },
    float = true,
    workspace = "unset",
  },
  {
    match = { class = "org.kde.polkit-kde-authentication-agent-1" },
    float = true,
    workspace = "unset",
  },
  { match = { class = "xdg-desktop-portal-gtk" }, float = true },
  { match = { class = "Unlock Database - KeePassXC" }, float = true },
  { match = { class = "net.code-industry.masterpdfeditor4" }, float = true },
  { match = { class = ".*Master PDF Editor.*" }, tile = true },
}
for _, x in ipairs(window_rules) do
  hl.window_rule(x)
end

hl.layer_rule { match = { namespace = "rofi" }, blur = true, no_anim = true }
hl.layer_rule { match = { namespace = "walker" }, blur = true, no_anim = true }

local monitors = package.searchpath("monitors", package.path)
    and require "monitors"
  or nil
