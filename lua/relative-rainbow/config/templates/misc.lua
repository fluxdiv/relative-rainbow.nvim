local M = {}

-- Cyberpunk
M.cyberpunk = {
  {
    distance_from_cursor = 11,
    hl_target = "editor",
    bg_tint = "#2E2E00", -- dark yellow
    fill = true
  },
  {
    distance_from_cursor = 11,
    hl_target = "number_column",
    fg = "#F200FF", -- neon pink
    fill = false
  },
  {
    distance_from_cursor = 22,
    hl_target = "editor",
    bg_tint = "#000000", -- black
    fill = true
  },
  {
    distance_from_cursor = 22,
    hl_target = "number_column",
    fg = "#37EBF3", -- neon blue
    fill = false
  },
}

return M
