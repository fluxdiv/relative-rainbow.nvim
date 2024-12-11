local M = {}

function math.round(num)
  return num + (2^52 + 2^51) - (2^52 + 2^51)
end

function math.clamp(num, min, max)
  return math.max(min, math.min(max, num))
end

-- goal: get x% between A and B
-- 50% is halfway
-- 50%:  A  + 0.5(distance between A & B)
-- 25%:  A  + 0.25(distance A & B)
local function shift_by_tint(base_val, tint_val, tint_multiplier)
  local abs_diff = math.abs(base_val - tint_val)
  -- subtract tint multiplier from 1, smaller tint multiplier = weaker tint shift
  -- TODO fix below
  -- if (1 - tint_multiplier) then default with tint works but rainbows with tint are solid color
  -- if (tint_multiplier) then rainbows with tint work but default with tint is inversed
  local tint_clamped = math.clamp(1 - tint_multiplier, 0, 1)
  local shifted = math.min(base_val, tint_val) + (abs_diff * tint_clamped)
  -- don't add or substract anything if abs_diff is == 0 ?
  return shifted
end

-- "Tint" a hex color between R,G,B of base_hex and tint_hex
M.add_tint = function(base_hex, tint_hex, tint_multiplier)
  -- lua is 1 based!
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

  -- default tint_multiplier if nil 0.5 (50% shift, midpt between colors)
  tint_multiplier = tint_multiplier or 0.5

  base_red = math.clamp(shift_by_tint(base_red, tint_red, tint_multiplier), 0, 255)
  base_green = math.clamp(shift_by_tint(base_green, tint_green, tint_multiplier), 0, 255)
  base_blue = math.clamp(shift_by_tint(base_blue, tint_blue, tint_multiplier), 0, 255)

  -- updated hex color
  return string.format("#%02x%02x%02x", base_red, base_green, base_blue)
end

-- ugly code
M.get_bg_hl_color = function(rainbow_step)
  if rainbow_step ~= nil then
    if rainbow_step.bg ~= nil then
      return rainbow_step.bg
    elseif rainbow_step.bg_tint ~= nil then
      local hl_normal = vim.api.nvim_get_hl(0, { name = "Normal" })
      local hl_normal_hex = hl_normal.bg and string.format("#%06x", hl_normal.bg) or nil
      if hl_normal_hex ~= nil then
        local tinted = M.add_tint(hl_normal_hex, rainbow_step.bg_tint, rainbow_step.tint_multiplier)
        return tinted
      end
    else
      return "#000000"
    end
  end
end

return M
