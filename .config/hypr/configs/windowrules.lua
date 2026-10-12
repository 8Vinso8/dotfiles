-- "Smart gaps" / "No gaps when only"
hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({
  name        = "no-gaps-wtv1",
  match       = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding    = 0,
})
hl.window_rule({
  name        = "no-gaps-f1",
  match       = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding    = 0,
})
-- end smart gaps

hl.window_rule({
  name           = "suppress-maximize-events",
  match          = { class = ".*" },
  suppress_event = "maximize",
})

hl.window_rule({
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

hl.window_rule({
  name = "scrolling-full-width",
  match = {
    class = "^zen$",
  },
  scrolling_width = 1.0,
})

hl.workspace_rule({
  workspace = "1",
  default = true,
  persistent = true,
  layout = "scrolling"
})

hl.window_rule({
  name = "mpv",
  match = {
    class = "^mpv$",
  },
  idle_inhibit = "focus",
  workspace = "2 silent",
  fullscreen = true,
  no_vrr = true,
})

hl.window_rule({
  name = "fullscreen-games",
  match = {
    tag = "game",
  },
  content = "game",
  workspace = "3 silent",
  fullscreen = true,
  border_size = 0,
  rounding = 0,
  no_anim = true,
  no_blur = true,
  no_dim = true,
  no_shadow = true,
  idle_inhibit = "always",
})

-- Games
hl.window_rule({
  name = "proton-game-tag",
  match = {
    class = "^steam_app_.*$",
  },
  tag = "+game",
})
-- Game specific fixes

-- BeamNG launcher
-- tile+pseudo fix it opening as a single line,
-- no_initial_focus fixes cursor not working on initial focus
hl.window_rule({
  name = "beamng-launcher-pseudotile",
  match = {
    title = "^BeamNG v\\d+\\.\\d+.\\d+.\\d+ Программа запуска$",
  },
  tag = "-game",
})
-- 3058630 - ac evo
hl.window_rule({
  name = "vrr-except",
  match = {
    class = "^steam_app_(?:3058630)$",
  },
  no_vrr = true,
})
