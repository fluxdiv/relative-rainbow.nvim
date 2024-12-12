local M = {}

-- Rainbow line dark
M.rainbow_line_dark = {
  { distance_from_cursor = 5, bg_tint = "#3D0300", bg_tint_multiplier = 0.1, fill = false }, -- Dark red
  { distance_from_cursor = 11, bg_tint = "#3a3d00", bg_tint_multiplier = 0.1, fill = false }, -- Dark yellow
  { distance_from_cursor = 17, bg_tint = "#003d0b", bg_tint_multiplier = 0.1, fill = false }, -- Dark green
  { distance_from_cursor = 22, bg_tint = "#00313d", bg_tint_multiplier = 0.1, fill = false }, -- Dark blue
}

-- Rainbow fill dark
M.rainbow_fill_dark = {
  { distance_from_cursor = 5, bg_tint = "#3D0300", bg_tint_multiplier = 0.1 }, -- Dark red
  { distance_from_cursor = 11, bg_tint = "#3a3d00", bg_tint_multiplier = 0.1 }, -- Dark yellow
  { distance_from_cursor = 17, bg_tint = "#003d0b", bg_tint_multiplier = 0.1 }, -- Dark green
  { distance_from_cursor = 22, bg_tint = "#00313d", bg_tint_multiplier = 0.1 }, -- Dark blue
}

-- Inner red, outer blue
M.rainbow_red_solid = {
  { distance_from_cursor = 3, bg = "#FF0000", fill = true }, -- Red
  { distance_from_cursor = 6, bg = "#FF7F00", fill = true }, -- Orange
  { distance_from_cursor = 9, bg = "#FFFF00", fill = true }, -- Yellow
  { distance_from_cursor = 12, bg = "#00FF00", fill = true }, -- Green
  { distance_from_cursor = 15, bg = "#0000FF", fill = true }, -- Blue
  { distance_from_cursor = 18, bg = "#4B0082", fill = true }, -- Indigo
  { distance_from_cursor = 21, bg = "#8B00FF", fill = true }, -- Violet
  { distance_from_cursor = 24, bg = "#8B00FF", fill = true }, -- Slightly lighter Violet
}

-- Inner red, outer blue
M.rainbow_red_tint = {
  { distance_from_cursor = 3, bg_tint = "#FF0000", bg_tint_multiplier = 0.1, fill = true }, -- Red
  { distance_from_cursor = 6, bg_tint = "#FF7F00", bg_tint_multiplier = 0.1, fill = true }, -- Orange
  { distance_from_cursor = 9, bg_tint = "#FFFF00", bg_tint_multiplier = 0.1, fill = true }, -- Yellow
  { distance_from_cursor = 12, bg_tint = "#00FF00", bg_tint_multiplier = 0.1, fill = true }, -- Green
  { distance_from_cursor = 15, bg_tint = "#0000FF", bg_tint_multiplier = 0.1, fill = true }, -- Blue
  { distance_from_cursor = 18, bg_tint = "#4B0082", bg_tint_multiplier = 0.1, fill = true }, -- Indigo
  { distance_from_cursor = 21, bg_tint = "#8B00FF", bg_tint_multiplier = 0.1, fill = true }, -- Violet
  { distance_from_cursor = 24, bg_tint = "#8B00FF", bg_tint_multiplier = 0.1, fill = true }, -- Slightly lighter Violet
}

-- Inner blue, outer red
M.rainbow_blue_solid = {
  { distance_from_cursor = 3, bg = "#0000FF", fill = true }, -- Blue
  { distance_from_cursor = 6, bg = "#00FF00", fill = true }, -- Green
  { distance_from_cursor = 9, bg = "#FFFF00", fill = true }, -- Yellow
  { distance_from_cursor = 12, bg = "#FF7F00", fill = true }, -- Orange
  { distance_from_cursor = 15, bg = "#FF0000", fill = true }, -- Red
  { distance_from_cursor = 18, bg = "#8B00FF", fill = true }, -- Violet
  { distance_from_cursor = 21, bg = "#4B0082", fill = true }, -- Indigo
  { distance_from_cursor = 24, bg = "#4B0082", fill = true }, -- Slightly lighter Indigo
}

-- Inner blue, outer red
M.rainbow_blue_tint = {
  { distance_from_cursor = 3, bg_tint = "#0000FF", bg_tint_multiplier = 0.1, fill = true }, -- Blue
  { distance_from_cursor = 6, bg_tint = "#00FF00", bg_tint_multiplier = 0.1, fill = true }, -- Green
  { distance_from_cursor = 9, bg_tint = "#FFFF00", bg_tint_multiplier = 0.1, fill = true }, -- Yellow
  { distance_from_cursor = 12, bg_tint = "#FF7F00", bg_tint_multiplier = 0.1, fill = true }, -- Orange
  { distance_from_cursor = 15, bg_tint = "#FF0000", bg_tint_multiplier = 0.1, fill = true }, -- Red
  { distance_from_cursor = 18, bg_tint = "#8B00FF", bg_tint_multiplier = 0.1, fill = true }, -- Violet
  { distance_from_cursor = 21, bg_tint = "#4B0082", bg_tint_multiplier = 0.1, fill = true }, -- Indigo
  { distance_from_cursor = 24, bg_tint = "#4B0082", bg_tint_multiplier = 0.1, fill = true }, -- Slightly lighter Indigo
}

return M

