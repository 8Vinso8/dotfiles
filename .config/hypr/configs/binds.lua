local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd("kitty"))

hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("rofi -show drun"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("~/.config/scripts/rofi/powermenu.sh"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("rofi -modi emoji -show emoji -emoji-format '{emoji}'"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist list | rofi -dmenu -theme '.config/rofi/clipboard.rasi' -no-custom -p Clipboard -display-columns 2 | cliphist decode | wl-copy"))

-- music controls
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p fooyin next"), { ignore_mods = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl -p fooyin play-pause"), { ignore_mods = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl -p fooyin previous"), { ignore_mods = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("playerctl -p fooyin volume 0.05+"), { ignore_mods = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("playerctl -p fooyin volume 0.05-"), { ignore_mods = true })

-- audio controls
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("~/.config/scripts/toggle-audio.sh"))
hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd("~/.config/scripts/toggle-microphone.sh"))
hl.bind(mainMod .. " + SHIFT + XF86AudioMute", hl.dsp.exec_cmd("~/.config/scripts/rofi/sinkchange.sh"))

hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd("~/.config/scripts/ddc-brightness.sh up"),
  { repeating = true }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd("~/.config/scripts/ddc-brightness.sh down"),
  { repeating = true }
)

hl.bind("Print", hl.dsp.exec_cmd("hyprshot --mode region --freeze --clipboard-only"))

-- Special workspace
hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:magic" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("ALT + TAB", hl.dsp.focus({ workspace = "previous" }))

-- Toggle layout scrolling/master SUPER + L
hl.bind(mainMod .. " + L", function()
  local ws = hl.get_active_workspace()
  if not ws then return end
  local layout = ws.tiled_layout == "master" and "scrolling" or "master"
  hl.workspace_rule({
    workspace = tostring(ws.id),
    layout = layout,
  })
end)

-- per layout binds, need to pass table with "layout = COMMAND"
local function layout_bind(bind_table)
  return function()
    local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()
    if not workspace then return end
    local layout = workspace.tiled_layout
    if bind_table[layout] then
      hl.dispatch(bind_table[layout])
    end
  end
end

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + F", layout_bind({
  scrolling = hl.dsp.layout("colresize 1.0")
}))

-- Scrolling: cycle trough column sizes SUPER + X
hl.bind(mainMod .. " + X", hl.dsp.layout("colresize +conf"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Move focus with mainMod + WASD
hl.bind(mainMod .. " + A", layout_bind({
  scrolling = hl.dsp.layout("focus left"),
  master = hl.dsp.focus({ direction = "left" }),
}))

hl.bind(mainMod .. " + D", layout_bind({
  scrolling = hl.dsp.layout("focus right"),
  master = hl.dsp.focus({ direction = "right" }),
}))

hl.bind(mainMod .. " + W", layout_bind({
  scrolling = hl.dsp.layout("focus up"),
  master = hl.dsp.focus({ direction = "up" }),
}))

hl.bind(mainMod .. " + S", layout_bind({
  scrolling = hl.dsp.layout("focus down"),
  master = hl.dsp.focus({ direction = "down" }),
}))

-- Move window/column with mainMod + SHIFT + AD
hl.bind(mainMod .. " + SHIFT + A", layout_bind({
  scrolling = hl.dsp.layout("swapcol l"),
  master = hl.dsp.layout("swapprev"),
}))
hl.bind(mainMod .. " + SHIFT + D", layout_bind({
  scrolling = hl.dsp.layout("swapcol r"),
  master = hl.dsp.layout("swapnext"),
}))
