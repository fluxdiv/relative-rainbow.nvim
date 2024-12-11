local M = {}

local colors = require('relative-rainbow.colors')

local defaults = require("relative-rainbow.config.defaults")
--- List of configuration steps
--- @type RelativeRainbowStep[]
local default_opts = defaults

-- Persistent
local ns_id = vim.api.nvim_create_namespace("relative_rainbow")
local opts = {}
-- local opts_mt = {}
-- overwrite lt to gt, so `table.sort()` sorts in descending order for correct hl order
-- lmao no
-- opts_mt.__lt = function(left, right)
--   return left.distance_from_cursor > right.distance_from_cursor
-- end

local apply_highlights = function()

  local buffer = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_clear_namespace(buffer, ns_id, 0, -1)

  -- disable within terminal buffers
  if vim.bo[buffer].buftype == "terminal" then
    return
  end

  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local total_lines = vim.api.nvim_buf_line_count(buffer)

  -- For each range in opts, apply highlights
  for index, rainbow_step in ipairs(opts) do
    local hl_bg_name = string.format("RelativeRainbow%dbg", index)

    local cursor_distance = rainbow_step.distance_from_cursor

    local bg_color = colors.get_bg_hl_color(rainbow_step)

    vim.api.nvim_set_hl(0, hl_bg_name, {
      bg = bg_color,
      fg = nil,
      blend = 100,
      default = false,
    })

    -- calc start & end lines
    local start_line = math.max(current_line - cursor_distance, 1) - 1
    local end_line = math.min(current_line + cursor_distance, total_lines) - 1

    -- If fill_mode = false, only apply highlight to start & end line
    if rainbow_step.fill_mode == false then
      for _, line in ipairs({start_line, end_line}) do
        vim.api.nvim_buf_set_extmark(buffer, ns_id, line, 0, {
          hl_group = hl_bg_name,
          line_hl_group = hl_bg_name,
          hl_eol = true
        })
      end
    else 
      -- apply bg highlight to each line in range
      -- This doesn't work as expected so manually set each line
      -- vim.api.nvim_buf_set_extmark(buffer, ns_id, start_line, 0, {
      --   hl_group = hl_bg_name,
      --   line_hl_group = hl_bg_name,
      --   hl_eol = true,
      --   end_line = end_line,
      --   -- end_col = end_line,
      -- })
      for line = start_line, end_line do
        -- vim.api.nvim_win_set_option(0, "cursorline", true)
        vim.api.nvim_buf_set_extmark(buffer, ns_id, line, 0, {
          hl_group = hl_bg_name,
          -- fix
          line_hl_group = hl_bg_name,
          hl_eol = true,
          -- hl_mode = "blend",
          -- number_hl_group = hl_bg_name,
          -- cursorline_hl_group = hl_bg_name,
        })
      end
    end
  end
end


--- Schema for a single configuration step in `relative-rainbow.nvim`.
--- @class RelativeRainbowStep
--- @field distance_from_cursor number Distance from the cursor to apply this highlight.
--- @field bg string|nil Solid background color in hexadecimal format (e.g., `"#FF0000"`). Takes precedence over `bg_tint` if provided.
--- @field bg_tint string|nil Tint to apply to the theme's existing background highlight.
--- @field tint_multiplier number Strength of the background tint, between 0 and 1. Larger values mean a stronger tint. Defaults to 0.5.
--- @field fill_mode boolean If `true`, highlights the entire range. If `false`, applies only to individual lines. Defaults to `true`.

--- Setup function for `relative-rainbow.nvim`.
--- Accepts a user configuration that overrides the default configuration.
---
--- Each entry in the configuration list should have the following fields:
--- - `distance_from_cursor` (number): Distance from the cursor to apply this highlight.
--- - `bg` (string|nil): Solid background color in hexadecimal format (e.g., `"#FF0000"`). Takes precedence over `bg_tint` if provided.
--- - `bg_tint` (string|nil): Tint to apply to the theme's existing background highlight.
--- - `tint_multiplier` (number): Strength of the background tint, between 0 and 1. Larger values mean a stronger tint. Defaults to 0.5.
--- - `fill_mode` (boolean): If `true`, highlights the entire range. If `false`, applies only to individual lines. Defaults to `true`.
---
--- Example usage:
--- ```lua
--- require("relative-rainbow").setup({
---   {
---     distance_from_cursor = 5,
---     bg_tint = "#FF0000",
---     tint_multiplier = 0.25,
---     fill_mode = false,
---   },
---   {
---     distance_from_cursor = 10,
---     bg_tint = "#00FF00",
---     tint_multiplier = 0.5,
---   },
--- })
--- ```
---
---@param user_opts RelativeRainbowStep[]|nil List of configuration steps. If `nil`, defaults are used.
function M.setup(user_opts)
  --- @type RelativeRainbowStep[]
  opts = user_opts or default_opts

  -- sort descending 
  table.sort(opts, function(a, b) return a.distance_from_cursor > b.distance_from_cursor end)

  vim.api.nvim_create_autocmd({ 'CursorMoved', 'WinEnter', 'BufEnter', 'BufWinEnter' }, {
    callback = apply_highlights,
    pattern = '*'
  })

end

return M
