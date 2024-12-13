local M = {}

function math.round(num)
  return num + (2 ^ 52 + 2 ^ 51) - (2 ^ 52 + 2 ^ 51)
end

function math.clamp(num, min, max)
  return math.max(min, math.min(max, num))
end

-- goal: get x% between A and B
-- 50% is halfway
-- 50%:  A  + 0.5(distance between A & B)
-- 25%:  A  + 0.25(distance A & B)
-- Some issues, likely with overflow clamping, maybe overflow wrap is better
local function shift_by_tint(base_val, tint_val, tint_multiplier)
  local abs_diff = math.abs(base_val - tint_val)
  -- subtract tint multiplier from 1, smaller tint multiplier = weaker tint shift
  -- Bug
  -- if (1 - tint_multiplier) then default with tint works but rainbows with tint are solid color
  -- if (tint_multiplier) then rainbows with tint work but default with tint is inversed
  local tint_clamped = math.clamp(1 - tint_multiplier, 0, 1)
  local shifted = math.min(base_val, tint_val) + (abs_diff * tint_clamped)
  -- don't add or substract anything if abs_diff is == 0 possibly
  return shifted
end

-- "Tint" a hex color between R,G,B of base_hex and tint_hex
M.add_tint = function(base_hex, tint_hex, tint_multiplier)
  -- #RRGGBB
  -- "RR" red
  local base_red = tonumber(base_hex:sub(2, 3), 16)
  -- "GG" green
  local base_green = tonumber(base_hex:sub(4, 5), 16)
  -- "BB" blue
  local base_blue = tonumber(base_hex:sub(6, 7), 16)

  local tint_red = tonumber(tint_hex:sub(2, 3), 16)
  local tint_green = tonumber(tint_hex:sub(4, 5), 16)
  local tint_blue = tonumber(tint_hex:sub(6, 7), 16)

  -- default tint_multiplier if nil 0.5 (midpt between colors)
  tint_multiplier = tint_multiplier or 0.5

  base_red = math.clamp(shift_by_tint(base_red, tint_red, tint_multiplier), 0, 255)
  base_green = math.clamp(shift_by_tint(base_green, tint_green, tint_multiplier), 0, 255)
  base_blue = math.clamp(shift_by_tint(base_blue, tint_blue, tint_multiplier), 0, 255)

  -- updated hex color
  return string.format("#%02x%02x%02x", base_red, base_green, base_blue)
end

---@class TargetGroup
---@field target "TARGET.editor"|"TARGET.number_column"
---@field bg string # Background color (hex)
---@field bg_tint string # Tinted background color (hex)
---@field bg_tint_multiplier number # Multiplier for background tint
---@field fg string # Foreground color (hex)
---@field fg_tint string # Tinted foreground color (hex)
---@field fg_tint_multiplier number # Multiplier for foreground tint

---@class TargetTable
---@field editor string # Highlight group for the editor
---@field number_column string # Highlight group for the number column

---@type TargetTable
local TARGET = {
  editor = "Normal",
  number_column = "LineNr",
}

---@param target_group TargetGroup #
---@return {bg_hl: string|nil, fg_hl: string|nil}|nil #
local function get_hl_group(target_group)
  local r = {
    bg_hl = nil,
    fg_hl = nil,
  }
  if target_group == nil then
    return r
  end

  local curr_hl = vim.api.nvim_get_hl(0, { name = target_group.target })
  if curr_hl == nil then
    return r
  end

  -- bg hl color
  if target_group.bg ~= nil then
    r.bg_hl = target_group.bg
  elseif target_group.bg_tint ~= nil then
    local hl_editor_hex = curr_hl.bg and string.format("#%06x", curr_hl.bg) or nil
    if hl_editor_hex ~= nil then
      local tinted_editor_bg = M.add_tint(hl_editor_hex, target_group.bg_tint, target_group.bg_tint_multiplier)
      r.bg_hl = tinted_editor_bg
    end
  end

  -- fg hl color
  if target_group.fg ~= nil then
    r.fg_hl = target_group.fg
  elseif target_group.fg_tint ~= nil then
    local hl_editor_hex = curr_hl.fg and string.format("#%06x", curr_hl.fg) or nil
    if hl_editor_hex ~= nil then
      local tinted_editor_fg = M.add_tint(hl_editor_hex, target_group.fg_tint, target_group.fg_tint_multiplier)
      r.fg_hl = tinted_editor_fg
    end
  end

  return r
end

---@return { editor_hls: { bg_hl: string|nil, fg_hl: string|nil }, numcol_hls: { bg_hl: string|nil, fg_hl: string|nil }}
M.get_hl_colors = function(rainbow_step)
  local r = {
    editor_hls = { bg_hl = nil, fg_hl = nil },
    numcol_hls = { bg_hl = nil, fg_hil = nil },
  }
  if rainbow_step == nil then
    return r
  end

  if rainbow_step.hl_target == "both" or rainbow_step.hl_target == nil then
    local nc = vim.tbl_extend("force", rainbow_step, { target = TARGET.number_column })
    local ed = vim.tbl_extend("force", rainbow_step, { target = TARGET.editor })
    r.numcol_hls = get_hl_group(nc)
    r.editor_hls = get_hl_group(ed)
  elseif rainbow_step.hl_target == "number_column" then
    local nc = vim.tbl_extend("force", rainbow_step, { target = TARGET.number_column })
    r.numcol_hls = get_hl_group(nc)
  elseif rainbow_step.hl_target == "editor" then
    local ed = vim.tbl_extend("force", rainbow_step, { target = TARGET.editor })
    r.editor_hls = get_hl_group(ed)
  end

  return r
end

return M
