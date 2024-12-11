--- Default configuration options for `relative-rainbow.nvim`.
--- This is a list of configuration steps, where each step defines highlight behavior.
---
--- Each table in the list contains the following fields:
--- - `distance_from_cursor` (number): Distance from the cursor to apply this highlight.
--- - `bg` (string|nil): Solid background color in hexadecimal format (e.g., `"#FF0000"`). Takes precedence over `bg_tint` if provided.
--- - `bg_tint` (string|nil): Tint to apply to the theme's existing background highlight.
--- - `tint_multiplier` (number): Strength of the background tint, between 0 and 1. Larger values mean a stronger tint. Defaults to 0.5.
--- - `fill_mode` (boolean): If `true`, highlights the entire range. If `false`, applies only to individual lines. Defaults to `true`.
---
--- Example:
--- {
---   {
---     distance_from_cursor = 5,
---     bg = "#FF0000",
---     bg_tint = "#00FF00",
---     tint_multiplier = 0.25,
---     fill_mode = false,
---   },
---   {
---     distance_from_cursor = 10,
---     bg_tint = "#0000FF",
---     tint_multiplier = 0.7,
---   }
--- }
---
---@type table[]
local default_opts = {
  {
    distance_from_cursor = 5,
    bg_tint = "#001702",
    tint_multiplier = 0.25,
  },
  {
    distance_from_cursor = 11,
    bg_tint = "#001702",
    tint_multiplier = 0.5,
  },
  {
    distance_from_cursor = 22,
    bg_tint = "#001702",
    tint_multiplier = 0.9,
  },
}

return default_opts

