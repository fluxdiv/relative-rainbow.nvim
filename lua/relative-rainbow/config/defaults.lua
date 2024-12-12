--- Default configuration options for `relative-rainbow.nvim`.
--- This is a list of configuration steps, where each step defines highlight behavior.
---
--- Each table in the list contains the following fields:
--- - `distance_from_cursor` (number): Distance from the cursor to apply this highlight.
--- - `bg` (string|nil): Solid background color in hexadecimal format (e.g., `"#FF0000"`). Takes precedence over `bg_tint` if provided.
--- - `bg_tint` (string|nil): Tint to apply to the theme's existing background highlight.
--- - `tint_multiplier` (number): Strength of the background tint, between 0 and 1. Larger values mean a stronger tint. Defaults to 0.5.
--- - `fill` (boolean): If `true`, highlights the entire range. If `false`, applies only to individual lines. Defaults to `true`.
--- - `hl_target` ("number_column"|"editor"|"both"|nil): Where to apply this highlight. Defaults to "both"
---
--- Example:
--- {
---   {
---     distance_from_cursor = 5,
---     bg = "#FF0000",
---     fill = false,
---     hl_target = "both"
---   },
---   {
---     distance_from_cursor = 10,
---     bg_tint = "#0000FF",
---     tint_multiplier = 0.7,
---     hl_target = "number_column"
---   },
---   {
---     distance_from_cursor = 15,
---     bg = "#00FF00",
---     hl_target = "editor"
---   }
--- }
---
---@type table[]
local default_opts = {
  {
    distance_from_cursor = 5,
    hl_target = "editor",
    bg_tint = "#001702",
    tint_multiplier = 0.25,
    fill = false,
  },
  {
    distance_from_cursor = 5,
    hl_target = "number_column",
    fg = "#00EDA6",
    fill = false,
  },
  {
    distance_from_cursor = 11,
    hl_target = "editor",
    bg_tint = "#001702",
    tint_multiplier = 0.5,
    fill = false,
  },
  {
    distance_from_cursor = 11,
    hl_target = "number_column",
    fg = "#00EDA6",
    fill = false,
  },
  {
    distance_from_cursor = 22,
    hl_target = "editor",
    bg_tint = "#001702",
    tint_multiplier = 0.9,
    fill = false,
  },
  {
    distance_from_cursor = 22,
    hl_target = "number_column",
    fg = "#00EDA6",
    fill = false,
  },
}

return default_opts

