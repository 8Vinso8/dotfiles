local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gears = require("gears")

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "sans 8"

theme.bg_normal     = "#181926"
theme.bg_focus      = "#c6a0f6"
theme.bg_urgent     = "#ed8796"
theme.bg_minimize   = "#444444"

theme.fg_normal     = "#cad3f5"
theme.fg_focus      = "#cad3f5"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.taglist_fg_occupied = "#cad3f5"
theme.taglist_fg_empty = "#5b6078"
theme.taglist_fg_focus = "#ffffff"

theme.useless_gap   = dpi(5)
theme.border_width  = dpi(3)
theme.border_normal = "#494d64"
theme.border_focus  = "#c6a0f6"
theme.border_marked = "#91231c"

theme.gap_single_client = false

theme.tasklist_disable_task_name    = true
theme.tasklist_plain_task_name      = true
theme.tasklist_bg_normal = "#24273a"

theme.bg_systray = "#24273a"
theme.systray_icon_spacing = 5

theme.notification_icon_size = 40
theme.notification_shape = gears.shape.rounded_rect
theme.notification_bg = "#24273a"
theme.notification_fg = "#cad3f5"
theme.notification_opacity = 0.8

theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

theme.wallpaper = "~/wallpapers/mountain.jpg"

theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, "#24273a", theme.bg_focus
)

theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
