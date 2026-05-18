# stille.nvim

**stille** /'ʃtɪlə/ · *noun* — stillness, silence, quietness.

> A minimalist Neovim colorscheme focused on reduction, offering dark, warm
> light, and absolute monochrome variants.

## Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "I0I-I0I/stille.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            require("stille").setup({
                -- your configuration here
            })
        vim.cmd.colo("stille-dunkel") -- or stille-hell, stille-leere
    end,
}
```

### Built-in pack

```lua
vim.pack.add({ "https://github.com/I0I-I0I/stille.nvim" })
vim.cmd.colo("stille-dunkel") -- or stille-hell, stille-leere
```

## Variants

### Stille dunkel

```vim
:colorscheme stille-dunkel
```

- Editor

![Editor](./assets/stille-dunkel.png)

- NeoGit

![NeoGit](./assets/stille-dunkel-git.png)

### Stille hell

```vim
:colorscheme stille-hell
```

- Editor

![Editor](./assets/stille-hell.png)

- NeoGit

![NeoGit](./assets/stille-hell-git.png)

### Stille leere

```vim
:colorscheme stille-leere
```

- Editor

![Editor](./assets/stille-leere.png)

- NeoGit

![NeoGit](./assets/stille-leere-git.png)

## Configuration

```lua
require("stille").setup({
    transparent = false,      -- Enable/disable background transparency
    terminal_colors = true,   -- Enable/disable terminal colors
    comment_italic = true,    -- Enable/disable italics for comments
    guicursor = true,         -- Enable/disable cursor styling
    color_overrides = {},     -- Override specific palette colors
})
```

### Color Overrides

You can override any color in the palette:

```lua
require("stille").setup({
    color_overrides = {
        bg = "#000000",
        fg = "#ffffff",
        -- see lua/stille/palette.lua for all available keys
    }
})
```

## License

MIT
