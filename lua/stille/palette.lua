---@class StillePaletteColor: vim.api.keyset.highlight

---@class StillePalette
---@field main StillePaletteColor
---@field comment StillePaletteColor
---@field keyword StillePaletteColor
---@field type StillePaletteColor
---@field string StillePaletteColor
---@field constant? StillePaletteColor
---@field func? StillePaletteColor
---@field number? StillePaletteColor
---@field operator? StillePaletteColor
---@field cursor StillePaletteColor
---@field cursorline StillePaletteColor
---@field git_add StillePaletteColor
---@field git_delete StillePaletteColor
---@field git_change StillePaletteColor
---@field git_text StillePaletteColor
---@field error StillePaletteColor
---@field warning StillePaletteColor
---@field info StillePaletteColor
---@field hint StillePaletteColor
---@field ok StillePaletteColor
---@field black StillePaletteColor
---@field red StillePaletteColor
---@field green StillePaletteColor
---@field yellow StillePaletteColor
---@field blue StillePaletteColor
---@field magenta StillePaletteColor
---@field cyan StillePaletteColor
---@field white StillePaletteColor

local M = {}

---@type table<string, StillePalette>
M.palettes = {
    dunkel = {
        main = { bg = "#0f0f0f", fg = "#ffffff" },

        comment = { fg = "#808080" },
        keyword = { fg = "#ff6347", bold = true },
        func = { fg = "#ffffff", bold = true },
        type = { fg = "#a3d5f7", italic = true },
        string = { fg = "#7bd88f" },
        constant = { fg = "#ffffff" },
        number = { fg = "#ffffff" },
        operator = { fg = "#ffffff" },
        cursor = { bg = "#ffffff" },
        cursorline = { bg = "#1a1a1a" },

        git_add = { fg = "#7bd88f", bg = "#102015" },
        git_delete = { fg = "#ff8e8e", bg = "#241217" },
        git_change = { fg = "#8fbaff", bg = "#12202d" },
        git_text = { bg = "#1a2c40" },

        error = { fg = "#ff8e8e" },
        warning = { fg = "#ffcc66" },
        info = { fg = "#8fbaff" },
        hint = { fg = "#7bd88f" },
        ok = { fg = "#7bd88f" },

        black = { fg = "#0f0f0f" },
        red = { fg = "#ff6347" },
        green = { fg = "#7bd88f" },
        yellow = { fg = "#ffcc66" },
        blue = { fg = "#8fbaff" },
        magenta = { fg = "#d3b1ff" },
        cyan = { fg = "#a3d5f7" },
        white = { fg = "#ffffff" },
    },
    hell = {
        main = { bg = "#faf7f0", fg = "#1f2430" },

        comment = { fg = "#6f7683" },
        keyword = { fg = "#d89e9e", bold = true },
        func = { fg = "#1f2430", bold = true },
        type = { fg = "#3f7ea6", italic = true },
        string = { fg = "#4d7f57" },
        constant = { fg = "#1f2430" },
        number = { fg = "#1f2430" },
        operator = { fg = "#1f2430" },
        cursor = { bg = "#9b9b9b" },
        cursorline = { bg = "#e1dbcd" },

        git_add = { fg = "#5f8f6b", bg = "#d9eadf" },
        git_delete = { fg = "#9a4f4f", bg = "#d89e9e" },
        git_change = { fg = "#8c7a2b", bg = "#d7d48d" },
        git_text = { bg = "#e6dfbf" },

        error = { fg = "#9a4f4f" },
        warning = { fg = "#8c7a2b" },
        info = { fg = "#3f7ea6" },
        hint = { fg = "#5f8f6b" },
        ok = { fg = "#5f8f6b" },

        black = { fg = "#faf7f0" },
        red = { fg = "#d89e9e" },
        green = { fg = "#4d7f57" },
        yellow = { fg = "#8c7a2b" },
        blue = { fg = "#3f7ea6" },
        magenta = { fg = "#a37acc" },
        cyan = { fg = "#5c8c8c" },
        white = { fg = "#1f2430" },
    },
    leere = {
        main = { bg = "#000000", fg = "#faf7f0" },

        comment = { fg = "#808080" },
        keyword = { fg = "#faf7f0", bold = true },
        func = { fg = "#faf7f0", bold = true },
        type = { fg = "#faf7f0", italic = true },
        string = { fg = "#faf7f0" },
        constant = { fg = "#faf7f0" },
        number = { fg = "#faf7f0" },
        operator = { fg = "#faf7f0" },
        cursor = { bg = "#faf7f0" },
        cursorline = { bg = "#1a1a1a" },

        git_add = { fg = "#7bd88f", bg = "#102015" },
        git_delete = { fg = "#ff8e8e", bg = "#241217" },
        git_change = { fg = "#8fbaff", bg = "#12202d" },
        git_text = { bg = "#1a2c40" },

        error = { fg = "#faf7f0" },
        warning = { fg = "#faf7f0" },
        info = { fg = "#faf7f0" },
        hint = { fg = "#faf7f0" },
        ok = { fg = "#faf7f0" },

        black = { fg = "#000000" },
        red = { fg = "#faf7f0" },
        green = { fg = "#faf7f0" },
        yellow = { fg = "#faf7f0" },
        blue = { fg = "#faf7f0" },
        magenta = { fg = "#faf7f0" },
        cyan = { fg = "#faf7f0" },
        white = { fg = "#faf7f0" },
    },
}

return M
