local M = {}

local colors = require("relative-rainbow.colors")
local defaults = require("relative-rainbow.config.defaults")

--- List of configuration steps
--- @type RelativeRainbowStep[]
local default_opts = defaults

-- Persistent
local ns_id = vim.api.nvim_create_namespace("relative_rainbow")
local opts = {}

--

local apply_highlights = function()
  local buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(buffer, ns_id, 0, -1)

  -- disable within terminal buffers
  if vim.bo[buffer].buftype == "terminal" then
    return
  end

  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local total_lines = vim.api.nvim_buf_line_count(buffer)

  local previous_A_start_line = nil
  local previous_B_end_line = nil

  -- For each range in opts, apply highlights
  for index, rainbow_step in ipairs(opts) do
    local hl_editor_name = string.format("RelativeRainbow%deditor", index)
    local hl_numcol_name = string.format("RelativeRainbow%dnumcol", index)

    local hl_groups = colors.get_hl_colors(rainbow_step)

    vim.api.nvim_set_hl(0, hl_editor_name, {
      bg = hl_groups.editor_hls.bg_hl,
      fg = hl_groups.editor_hls.fg_hl,
      blend = 100,
      default = false,
    })

    vim.api.nvim_set_hl(0, hl_numcol_name, {
      bg = hl_groups.numcol_hls.bg_hl,
      fg = hl_groups.numcol_hls.fg_hl,
      blend = 100,
      default = false,
    })

    -- opts for ext_marks to be set
    local extmark_opts = {
      -- hl_group doesn't matter
      -- hl_group = hl_bg_name,
      hl_eol = true,
    }

    if rainbow_step.hl_target == nil or rainbow_step.hl_target == "both" then
      extmark_opts.line_hl_group = hl_editor_name
      extmark_opts.number_hl_group = hl_numcol_name
    elseif rainbow_step.hl_target == "number_column" then
      extmark_opts.number_hl_group = hl_numcol_name
    elseif rainbow_step.hl_target == "editor" then
      extmark_opts.line_hl_group = hl_editor_name
    end

    -- calc start & end lines
    local cursor_distance = rainbow_step.distance_from_cursor
    local nofill_lines = {}
    local fill_ranges = {}

    -- If this is first rainbow_step, then basic start/end calculation,
    -- and table will need to be sorted ascending cursor distance
    if index == 1 then
      local start_line = math.max(current_line - cursor_distance, 1) - 1
      previous_A_start_line = start_line
      local end_line = math.min(current_line + cursor_distance, total_lines) - 1
      previous_B_end_line = end_line

      if rainbow_step.fill == false then
        table.insert(nofill_lines, start_line)
        table.insert(nofill_lines, end_line)
      else
        table.insert(fill_ranges, { start_line, end_line })
      end
    else
      -- Not first rainbow step, need 2 line ranges
      local A_start_line = math.max(current_line - cursor_distance, 1) - 1
      local A_end_line = math.max(previous_A_start_line or 1, 1)
      previous_A_start_line = A_start_line

      local B_start_line = math.min(previous_B_end_line or total_lines, total_lines)
      local B_end_line = math.min(current_line + cursor_distance, total_lines) - 1
      previous_B_end_line = B_end_line

      if rainbow_step.fill == false then
        nofill_lines = {}
        table.insert(nofill_lines, A_start_line)
        -- table.insert(nofill_lines, A_end_line)
        -- table.insert(nofill_lines, B_start_line)
        table.insert(nofill_lines, B_end_line)
      else
        fill_ranges = {}
        table.insert(fill_ranges, { A_start_line, A_end_line })
        table.insert(fill_ranges, { B_start_line, B_end_line })
      end
    end

    if rainbow_step.fill == false then
      for _, line in ipairs(nofill_lines) do
        vim.api.nvim_buf_set_extmark(buffer, ns_id, line, 0, extmark_opts)
      end
    else
      for _, range in ipairs(fill_ranges) do
        for line = range[1], range[2] do
          vim.api.nvim_buf_set_extmark(buffer, ns_id, line, 0, extmark_opts)
        end
      end
    end
  end
end

--- Schema for a single configuration step in `relative-rainbow.nvim`.
--- @class RelativeRainbowStep
--- @field distance_from_cursor number Distance from the cursor to apply this highlight.
--- @field bg string|nil Solid background color in hexadecimal format (e.g., `"#FF0000"`). Takes precedence over `bg_tint` if provided.
--- @field bg_tint string|nil Tint to apply to the theme's existing background highlight.
--- @field bg_tint_multiplier number Strength of the background tint, between 0 and 1. Larger values mean a stronger tint. Defaults to 0.5.
--- @field fg (string|nil): Solid foreground color in hexadecminal format. Takes precedence over `fg_tint` if provided.
--- @field fg_tint (string|nil): Tint to apply to the theme's existing foreground highlight.
--- @field fg_tint_multiplier (number): Strength of fg tint, between 0 and 1. Larger value means stronger tint. Defaults to 0.5.
--- @field fill boolean If `true`, highlights the entire range. If `false`, applies only to individual lines. Defaults to `true`.
--- @field hl_target "number_column"|"editor"|"both"|nil Where to apply this highlight. Defaults to `"both"`

--- Setup function for `relative-rainbow.nvim`.
---
--- Each entry in the configuration list should have the following fields:
--- - `distance_from_cursor` (number): Distance from the cursor to apply this highlight.
--- - `bg` (string|nil): Solid background color in hexadecimal format (e.g., `"#FF0000"`). Takes precedence over `bg_tint` if provided.
--- - `bg_tint` (string|nil): Tint to apply to the theme's existing background highlight.
--- - `bg_tint_multiplier` (number): Strength of the background tint, between 0 and 1. Larger values mean a stronger tint. Defaults to 0.5.
--- - `fg` (string|nil): Solid foreground color in hexadecminal format. Takes precedence over `fg_tint` if provided.
--- - `fg_tint` (string|nil): Tint to apply to the theme's existing foreground highlight.
--- - `fg_tint_multiplier` (number): Strength of fg tint, between 0 and 1. Larger value means stronger tint. Defaults to 0.5.
--- - `fill` (boolean): If `true`, highlights the entire range. If `false`, applies only to individual lines. Defaults to `true`.
--- - `hl_target` ("number_column"|"editor"|"both"|nil): Where to apply this highlight. Defaults to `"both"`
---
--- Example usage:
--- ```lua
--- require("relative-rainbow").setup({
---   {
---     distance_from_cursor = 5,
---     bg_tint = "#FF0000",
---     bg_tint_multiplier = 0.25,
---     fg = "#00FFD0",
---     fill = false,
---     hl_target = "number_column",
---   },
---   {
---     distance_from_cursor = 10,
---     bg_tint = "#00FF00",
---     bg_tint_multiplier = 0.5,
---     hl_target = "editor",
---   },
--- })
--- ```
---
---@param user_opts RelativeRainbowStep[]|nil List of configuration steps. If `nil`, defaults are used.
function M.setup(user_opts)
  --- @type RelativeRainbowStep[]
  opts = user_opts or default_opts

  -- sort ascending
  table.sort(opts, function(a, b)
    return a.distance_from_cursor < b.distance_from_cursor
  end)

  vim.api.nvim_create_autocmd({ "CursorMoved", "WinEnter", "BufEnter", "BufWinEnter" }, {
    callback = apply_highlights,
    pattern = "*",
  })
end

return M
