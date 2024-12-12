# relative-rainbow.nvim

Neovim plugin for quick visual hints of relative distances from your cursor

[relative_rainbow_example](https://github.com/user-attachments/assets/0c76f5e1-6242-4a7b-86c7-de4d06abd447)

## Motivation
- Visual hints require less cognitive bandwidth to parse when compared to a long list of numbers
- ooo pretty colors

---

## Installation

### With `lazy.nvim`
```lua
{
  'fluxdiv/relative-rainbow.nvim',
  config = function()
    require("relative-rainbow").setup()
  end
}
```

### With Packer
```lua
use {
  'fluxdiv/relative-rainbow.nvim',
  config = function()
    require("relative-rainbow").setup()
  end
}
```

## Basic Usage

### Default config
To use the default config just call `.setup()` with no params/nil (see `./lua/relative-rainbow/config/defaults.lua`)
```lua
require("relative-rainbow").setup()
```

### Template configs
`relative-rainbow.nvim` includes multiple template configs (see `./lua/relative-rainbow/config/templates/`)
```lua
{
  'fluxdiv/relative-rainbow.nvim',
  config = function()
    local grayscale_templates = require("relative-rainbow.config.templates.grayscale")
    require("relative-rainbow").setup(grayscale_templates.grayscale_tint_line)

    local rainbow_templates = require("relative-rainbow.config.templates.rainbow")
    require("relative-rainbow").setup(rainbow_templates.rainbow_blue_tint)
  end
}
```

### Custom config
You can customize your config by passing a table of config options to `.setup()`. Each entry represents a "step" and supports the following fields:
- `distance_from_cursor` (number): Distance from cursor to apply highlight
- `bg` (string|nil): Solid background color in hex (ex "#FF0000")
- `bg_tint` (string|nil): Apply a tint color to current theme's bg (instead of a solid color)
- `tint_multiplier` (number|nil): Strength of tint (between 0 and 1). Larger = stronger tint
- `fill` (boolean): If `true`, highlights the entire range. If `false` only highlights the 2 individual lines @ `distance_from_cursor`. Defaults to `true`

### Example custom config
```lua
{
  'fluxdiv/relative-rainbow.nvim',
  config = function()
    require("relative-rainbow").setup({
      { distance_from_cursor = 5, bg = "#123456", fill = true },
      { distance_from_cursor = 10, bg_tint = "#654321", tint_multiplier = 0.5, fill = false },
      { distance_from_cursor = 15, bg_tint = "#FF0000", tint_multiplier = 0.75, fill = true },
    })
  end
}
```

### Create your own templates
You can also define your own templates and store them in your config for reuse:
```lua
-- ~/.config/nvim/lua/my_templates.lua
local M = {}

M.my_custom_template = {
  { distance_from_cursor = 3, bg = "#FF0000", fill = true }, -- Red
  { distance_from_cursor = 6, bg = "#00FF00", fill = true }, -- Green
  { distance_from_cursor = 9, bg = "#0000FF", fill = true }, -- Blue
}

return M
```

```lua
-- ~/.config/nvim/lua/init.lua
{
  'fluxdiv/relative-rainbow.nvim',
  config = function()
    local my_templates = require("my_templates")
    requre("relative-rainbow").setup(my_templates.my_custom_template)
  end
}
```
