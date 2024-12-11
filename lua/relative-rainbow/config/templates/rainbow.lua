local M = {}

-- Inner red, outer blue
M.rainbow_red_solid = {
  { distance_from_cursor = 3, bg = "#FF0000", fill_mode = true }, -- Red
  { distance_from_cursor = 6, bg = "#FF7F00", fill_mode = true }, -- Orange
  { distance_from_cursor = 9, bg = "#FFFF00", fill_mode = true }, -- Yellow
  { distance_from_cursor = 12, bg = "#00FF00", fill_mode = true }, -- Green
  { distance_from_cursor = 15, bg = "#0000FF", fill_mode = true }, -- Blue
  { distance_from_cursor = 18, bg = "#4B0082", fill_mode = true }, -- Indigo
  { distance_from_cursor = 21, bg = "#8B00FF", fill_mode = true }, -- Violet
  { distance_from_cursor = 24, bg = "#8B00FF", fill_mode = true }, -- Slightly lighter Violet
}

-- Inner red, outer blue
M.rainbow_red_tint = {
  { distance_from_cursor = 3, bg_tint = "#FF0000", tint_multiplier = 0.1, fill_mode = true }, -- Red
  { distance_from_cursor = 6, bg_tint = "#FF7F00", tint_multiplier = 0.1, fill_mode = true }, -- Orange
  { distance_from_cursor = 9, bg_tint = "#FFFF00", tint_multiplier = 0.1, fill_mode = true }, -- Yellow
  { distance_from_cursor = 12, bg_tint = "#00FF00", tint_multiplier = 0.1, fill_mode = true }, -- Green
  { distance_from_cursor = 15, bg_tint = "#0000FF", tint_multiplier = 0.1, fill_mode = true }, -- Blue
  { distance_from_cursor = 18, bg_tint = "#4B0082", tint_multiplier = 0.1, fill_mode = true }, -- Indigo
  { distance_from_cursor = 21, bg_tint = "#8B00FF", tint_multiplier = 0.1, fill_mode = true }, -- Violet
  { distance_from_cursor = 24, bg_tint = "#8B00FF", tint_multiplier = 0.1, fill_mode = true }, -- Slightly lighter Violet
}

-- Inner blue, outer red
M.rainbow_blue_solid = {
  { distance_from_cursor = 3, bg = "#0000FF", fill_mode = true }, -- Blue
  { distance_from_cursor = 6, bg = "#00FF00", fill_mode = true }, -- Green
  { distance_from_cursor = 9, bg = "#FFFF00", fill_mode = true }, -- Yellow
  { distance_from_cursor = 12, bg = "#FF7F00", fill_mode = true }, -- Orange
  { distance_from_cursor = 15, bg = "#FF0000", fill_mode = true }, -- Red
  { distance_from_cursor = 18, bg = "#8B00FF", fill_mode = true }, -- Violet
  { distance_from_cursor = 21, bg = "#4B0082", fill_mode = true }, -- Indigo
  { distance_from_cursor = 24, bg = "#4B0082", fill_mode = true }, -- Slightly lighter Indigo
}

-- Inner blue, outer red
M.rainbow_blue_tint = {
  { distance_from_cursor = 3, bg_tint = "#0000FF", tint_multiplier = 0.1, fill_mode = true }, -- Blue
  { distance_from_cursor = 6, bg_tint = "#00FF00", tint_multiplier = 0.1, fill_mode = true }, -- Green
  { distance_from_cursor = 9, bg_tint = "#FFFF00", tint_multiplier = 0.1, fill_mode = true }, -- Yellow
  { distance_from_cursor = 12, bg_tint = "#FF7F00", tint_multiplier = 0.1, fill_mode = true }, -- Orange
  { distance_from_cursor = 15, bg_tint = "#FF0000", tint_multiplier = 0.1, fill_mode = true }, -- Red
  { distance_from_cursor = 18, bg_tint = "#8B00FF", tint_multiplier = 0.1, fill_mode = true }, -- Violet
  { distance_from_cursor = 21, bg_tint = "#4B0082", tint_multiplier = 0.1, fill_mode = true }, -- Indigo
  { distance_from_cursor = 24, bg_tint = "#4B0082", tint_multiplier = 0.1, fill_mode = true }, -- Slightly lighter Indigo
}

return M

