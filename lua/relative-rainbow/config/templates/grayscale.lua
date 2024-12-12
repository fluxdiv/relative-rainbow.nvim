local M = {}

M.grayscale = {
  { distance_from_cursor = 5, bg = "#000000", fill = true }, -- Black
  { distance_from_cursor = 11, bg = "#2E2E2E", fill = true }, -- Dark Gray
  { distance_from_cursor = 22, bg = "#5A5A5A", fill = true }, -- Lighter Gray
}
M.grayscale_line = {
  { distance_from_cursor = 5, bg = "#000000", fill = false }, -- Black
  { distance_from_cursor = 11, bg = "#2E2E2E", fill = false }, -- Dark Gray
  { distance_from_cursor = 22, bg = "#5A5A5A", fill = false }, -- Lighter Gray
}
M.grayscale_tint = {
  { distance_from_cursor = 5, bg_tint = "#000000", tint_multiplier = 0.25, fill = true },
  { distance_from_cursor = 11, bg_tint = "#2E2E2E", tint_multiplier = 0.25, fill = true },
  { distance_from_cursor = 22, bg_tint = "#505050", tint_multiplier = 0.25, fill = true },
}
M.grayscale_tint_line = {
  { distance_from_cursor = 5, bg_tint = "#000000", tint_multiplier = 0.25, fill = false },
  { distance_from_cursor = 11, bg_tint = "#2E2E2E", tint_multiplier = 0.25, fill = false },
  { distance_from_cursor = 22, bg_tint = "#5A5A5A", tint_multiplier = 0.25, fill = false },
}

return M
