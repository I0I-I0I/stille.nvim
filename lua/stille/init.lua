local config = require("stille.config")
local palette = require("stille.palette")

---@alias StilleGroup string

---@alias StilleHighlightOpts vim.api.keyset.highlight

---@class StilleVariant
---@field name string
---@field background? string
---@field palette StillePalette
---@field terminal_colors? boolean
---@field guicursor? string|boolean

---@class StilleGroupSpec
---@field style fun(variant: StilleVariant): StilleHighlightOpts
---@field groups StilleGroup[]

local M = {}

M.setup = config.setup

local initial_guicursor = vim.o.guicursor

---@param current string
---@param hl_group string
---@return string
local function apply_cursor_hl(current, hl_group)
    local parts = vim.split(current, ",")
    local new_parts = {}
    for _, part in ipairs(parts) do
        if part:find(":") then
            table.insert(new_parts, part .. "-" .. hl_group)
        else
            table.insert(new_parts, part)
        end
    end
    return table.concat(new_parts, ",")
end

---@type fun(ns_id: integer, name: string, val: vim.api.keyset.highlight)
local set = vim.api.nvim_set_hl

---@param base table
---@param override table
---@return table
local function merge(base, override)
    return vim.tbl_deep_extend("force", base or {}, override or {})
end

---@param variant StilleVariant
---@return string|integer|nil
local function normal_bg(variant)
    return variant.palette.main.bg
end

---@param variant StilleVariant
---@return string|integer|nil
local function menu_bg(variant)
    if variant.palette.main.bg == "NONE" then
        return variant.palette.cursorline.bg
    end

    return variant.palette.main.bg
end

---@param variant StilleVariant
---@return string|integer|nil
local function cursor_fg(variant)
    if variant.palette.main.bg == "NONE" then
        return variant.palette.cursorline.bg
    end

    return variant.palette.main.bg
end

---@type StilleGroupSpec[]
local highlight_groups = {
    {
        style = function(variant)
            return merge(variant.palette.error, { bold = true })
        end,
        groups = {
            "DiagnosticError",
            "DiagnosticFloatingError",
            "DiagnosticSignError",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.warning, { bold = true })
        end,
        groups = {
            "DiagnosticWarn",
            "DiagnosticFloatingWarn",
            "DiagnosticSignWarn",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.info, { bold = true })
        end,
        groups = {
            "DiagnosticInfo",
            "DiagnosticFloatingInfo",
            "DiagnosticSignInfo",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.hint, { bold = true })
        end,
        groups = {
            "DiagnosticHint",
            "DiagnosticFloatingHint",
            "DiagnosticSignHint",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.ok, { bold = true })
        end,
        groups = {
            "DiagnosticOk",
            "DiagnosticFloatingOk",
            "DiagnosticSignOk",
        },
    },
    {
        style = function(variant)
            return variant.palette.error
        end,
        groups = {
            "DiagnosticVirtualTextError",
        },
    },
    {
        style = function(variant)
            return variant.palette.warning
        end,
        groups = {
            "DiagnosticVirtualTextWarn",
        },
    },
    {
        style = function(variant)
            return variant.palette.info
        end,
        groups = {
            "DiagnosticVirtualTextInfo",
        },
    },
    {
        style = function(variant)
            return variant.palette.hint
        end,
        groups = {
            "DiagnosticVirtualTextHint",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.error, { sp = variant.palette.error.fg, undercurl = true })
        end,
        groups = {
            "DiagnosticUnderlineError",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.warning, { sp = variant.palette.warning.fg, undercurl = true })
        end,
        groups = {
            "DiagnosticUnderlineWarn",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.info, { sp = variant.palette.info.fg, undercurl = true })
        end,
        groups = {
            "DiagnosticUnderlineInfo",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.hint, { sp = variant.palette.hint.fg, undercurl = true })
        end,
        groups = {
            "DiagnosticUnderlineHint",
        },
    },
    {
        style = function(variant)
            return variant.palette.main
        end,
        groups = {
            "Normal",
        },
    },
    {
        style = function(variant)
            return variant.palette.git_add
        end,
        groups = {
            "DiffAdd",
        },
    },
    {
        style = function(variant)
            return variant.palette.git_delete
        end,
        groups = {
            "DiffDelete",
        },
    },
    {
        style = function(variant)
            return variant.palette.git_change
        end,
        groups = {
            "DiffChange",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_text, { bold = true })
        end,
        groups = {
            "DiffText",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_add, { bg = normal_bg(variant), bold = true })
        end,
        groups = {
            "Added",
            "DiffAdded",
            "diffAdded",
            "@diff.plus",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_delete, { bg = normal_bg(variant), bold = true })
        end,
        groups = {
            "Removed",
            "DiffRemoved",
            "diffRemoved",
            "@diff.minus",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_change, { bg = normal_bg(variant), bold = true })
        end,
        groups = {
            "Changed",
            "DiffChanged",
            "diffChanged",
            "@diff.delta",
            "DiffFile",
            "DiffNewFile",
            "DiffLine",
            "DiffIndexLine",
        },
    },
    {
        style = function(variant)
            return { fg = cursor_fg(variant), bg = variant.palette.cursor.bg, nocombine = true }
        end,
        groups = {
            "Cursor",
            "lCursor",
            "CursorIM",
            "TermCursor",
            "TermCursorNC",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.comment, { bg = normal_bg(variant) })
        end,
        groups = {
            "LineNr",
            "LineNrAbove",
            "LineNrBelow",
            "SignColumn",
            "Folded",
            "FoldColumn",
            "MarkSignNumHL",
            "MarkVirtTextHL",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.keyword, { bg = normal_bg(variant), bold = true })
        end,
        groups = {
            "MarkSignHL",
        },
    },
    {
        style = function(variant)
            return variant.palette.cursorline
        end,
        groups = {
            "CursorLine",
            "CursorColumn",
            "CursorLineFold",
            "CursorLineSign",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.keyword, { bg = variant.palette.cursorline.bg, bold = true })
        end,
        groups = {
            "CursorLineNr",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.main, { bg = variant.palette.cursorline.bg })
        end,
        groups = {
            "LspReferenceText",
            "LspReferenceRead",
            "LspReferenceWrite",
            "Visual",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.main, { bg = menu_bg(variant) })
        end,
        groups = {
            "Pmenu",
            "BlinkCmpMenu",
            "BlinkCmpDoc",
            "BlinkCmpSignatureHelp",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.main, { bg = variant.palette.cursorline.bg, bold = true })
        end,
        groups = {
            "PmenuSel",
            "WildMenu",
            "BlinkCmpMenuSelection",
            "BlinkCmpDocCursorLine",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.comment, { bg = menu_bg(variant) })
        end,
        groups = {
            "PmenuKind",
            "PmenuExtra",
            "BlinkCmpLabelDeprecated",
            "BlinkCmpLabelDetail",
            "BlinkCmpLabelDescription",
            "BlinkCmpSource",
            "BlinkCmpMenuBorder",
            "BlinkCmpDocBorder",
            "BlinkCmpDocSeparator",
            "BlinkCmpSignatureHelpBorder",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.comment, { bg = variant.palette.cursorline.bg })
        end,
        groups = {
            "PmenuExtraSel",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.keyword, { bg = menu_bg(variant), bold = true })
        end,
        groups = {
            "BlinkCmpLabelMatch",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.main, { bg = menu_bg(variant) })
        end,
        groups = {
            "BlinkCmpLabel",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.type, { bg = menu_bg(variant) })
        end,
        groups = {
            "BlinkCmpKind",
        },
    },
    {
        style = function(variant)
            return { bg = menu_bg(variant) }
        end,
        groups = {
            "PmenuSbar",
            "BlinkCmpScrollBarGutter",
        },
    },
    {
        style = function(variant)
            return { bg = variant.palette.comment.fg }
        end,
        groups = {
            "PmenuThumb",
            "BlinkCmpScrollBarThumb",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.main, { bg = normal_bg(variant) })
        end,
        groups = {
            "StatusLine",
            "StatusLineTerm",
            "TabLineSel",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.comment, { bg = normal_bg(variant) })
        end,
        groups = {
            "StatusLineNC",
            "StatusLineTermNC",
            "TabLine",
            "TabLineFill",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.main, { bg = normal_bg(variant) })
        end,
        groups = {
            "NormalFloat",
            "FloatTitle",
            "FloatFooter",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.comment, { bg = normal_bg(variant) })
        end,
        groups = {
            "FloatBorder",
            "WinSeparator",
            "VertSplit",
        },
    },
    {
        style = function(variant)
            return variant.palette.comment
        end,
        groups = {
            "Comment",
            "@comment",
            "@comment.documentation",
            "gitcommitComment",
            "gitcommitOnBranch",
            "gitcommitArrow",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.keyword, { bold = true })
        end,
        groups = {
            "@comment.todo",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.keyword, { bold = true })
        end,
        groups = {
            "Label",
            "gitcommitSummary",
            "gitcommitTrailerToken",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_change, { bold = true })
        end,
        groups = {
            "@comment.warning",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.type, { bold = true })
        end,
        groups = {
            "PreProc",
            "Title",
            "gitcommitHeader",
            "gitcommitType",
            "gitcommitBranch",
            "gitcommitNoBranch",
            "gitcommitNoChanges",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.type, { bold = true })
        end,
        groups = {
            "@comment.note",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_delete, { bold = true })
        end,
        groups = {
            "@comment.error",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.keyword, { bold = true })
        end,
        groups = {
            "Statement",
            "Keyword",
            "Conditional",
            "Repeat",
            "Include",
            "Define",
            "Macro",
            "PreProc",
            "@keyword",
            "@keyword.import",
            "@keyword.function",
            "@keyword.return",
            "@keyword.conditional",
            "@keyword.conditional.ternary",
            "@keyword.repeat",
            "@keyword.exception",
            "@keyword.operator",
            "@keyword.type",
            "@keyword.modifier",
            "@keyword.directive",
            "@keyword.directive.define",
            "@keyword.coroutine",
            "@keyword.export",
            "@attribute",
            "@attribute.builtin",
            "@label",

            "@tag",
            "@tag.builtin",
            "@tag.delimiter",
            "@keyword.svelte",
            "@attribute.svelte",
        },
    },
    {
        style = function(variant)
            return variant.palette.main
        end,
        groups = {
            "@tag.attribute",
            "@property",
            "@variable",
            "@variable.builtin",
            "@variable.parameter",
            "@variable.parameter.builtin",
            "@variable.member",
            "@variable.field",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.type, { bold = true })
        end,
        groups = {
            "Type",
            "StorageClass",
            "Structure",
            "Typedef",

            "@type.tag",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.constant or variant.palette.main, { bold = true })
        end,
        groups = {
            "@module",
            "@module.builtin",
        },
    },
    {
        style = function(variant)
            return variant.palette.main
        end,
        groups = {
            "Exception",
        },
    },
    {
        style = function(variant)
            return variant.palette.string
        end,
        groups = {
            "String",
            "Character",
            "@string",
            "@string.documentation",
            "@string.regexp",
            "@string.escape",
            "@string.special",
            "@string.special.symbol",
            "@string.special.url",
            "@string.special.path",
            "@character",
            "@character.special",

            "@markup.link",
            "@markup.link.label",
        },
    },
    {
        style = function(variant)
            return variant.palette.number or variant.palette.main
        end,
        groups = {
            "Number",
            "Boolean",
            "Float",
            "@number",
            "@number.float",
            "@boolean",
        },
    },
    {
        style = function(variant)
            return variant.palette.func or variant.palette.main
        end,
        groups = {
            "Function",
            "@function",
            "@function.builtin",
            "@function.call",
            "@function.method",
            "@function.method.call",
            "@constructor",
        },
    },
    {
        style = function(variant)
            return variant.palette.constant or variant.palette.main
        end,
        groups = {
            "Constant",
            "@constant",
            "@constant.builtin",
        },
    },
    {
        style = function(variant)
            return variant.palette.operator or variant.palette.main
        end,
        groups = {
            "Operator",
            "@operator",
        },
    },
    {
        style = function(variant)
            return variant.palette.main
        end,
        groups = {
            "Identifier",
            "Special",
            "Delimiter",

            "@punctuation.delimiter",
            "@punctuation.bracket",
            "@punctuation.special",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.type, { italic = true, bold = true })
        end,
        groups = {
            "@type",
            "@type.builtin",
            "@type.definition",

            "@markup.heading",
        },
    },
    {
        style = function(variant)
            return variant.palette.string
        end,
        groups = {
            "gitcommitFile",
            "gitcommitUntrackedFile",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_add, { bold = true })
        end,
        groups = {
            "gitcommitSelectedType",
            "gitcommitSelectedFile",
            "gitcommitSelectedArrow",
        },
    },
    {
        style = function(variant)
            return merge(variant.palette.git_delete, { bold = true })
        end,
        groups = {
            "Error",
            "gitcommitDiscardedType",
            "gitcommitDiscardedFile",
            "gitcommitDiscardedArrow",
            "gitcommitUnmergedType",
            "gitcommitUnmergedFile",
            "gitcommitUnmergedArrow",
            "gitcommitOverflow",
            "gitcommitBlank",
        },
    },
}

---@param groups StilleGroup[]
---@param opts StilleHighlightOpts
local function apply(groups, opts)
    for _, group in ipairs(groups) do
        set(0, group, opts)
    end
end

---@param variant_name string
function M.load(variant_name)
    local p = palette.palettes[variant_name]
    if not p then
        error("Palette not found: " .. variant_name)
    end

    p = vim.deepcopy(p)
    p = vim.tbl_deep_extend("force", p, config.options.color_overrides)

    if config.options.transparent then
        p.main.bg = "NONE"
    end

    if config.options.comment_italic ~= nil then
        p.comment.italic = config.options.comment_italic
    end

    local variant = {
        name = "stille-" .. variant_name,
        background = variant_name == "hell" and "light" or "dark",
        palette = p,
        terminal_colors = config.options.terminal_colors,
        guicursor = config.options.guicursor,
    }

    vim.cmd("highlight clear")
    vim.cmd("syntax on")
    if vim.fn.exists("syntax_on") == 1 then
        vim.cmd("syntax reset")
    end

    vim.g.colors_name = variant.name
    vim.opt.termguicolors = true

    if variant.background then
        vim.opt.background = variant.background
    end

    for _, spec in ipairs(highlight_groups) do
        apply(spec.groups, spec.style(variant))
    end

    -- Terminal colors
    if variant.terminal_colors then
        vim.g.terminal_color_0 = variant.palette.black.fg
        vim.g.terminal_color_1 = variant.palette.red.fg
        vim.g.terminal_color_2 = variant.palette.green.fg
        vim.g.terminal_color_3 = variant.palette.yellow.fg
        vim.g.terminal_color_4 = variant.palette.blue.fg
        vim.g.terminal_color_5 = variant.palette.magenta.fg
        vim.g.terminal_color_6 = variant.palette.cyan.fg
        vim.g.terminal_color_7 = variant.palette.white.fg
        vim.g.terminal_color_8 = variant.palette.comment.fg
        vim.g.terminal_color_9 = variant.palette.red.fg
        vim.g.terminal_color_10 = variant.palette.green.fg
        vim.g.terminal_color_11 = variant.palette.yellow.fg
        vim.g.terminal_color_12 = variant.palette.blue.fg
        vim.g.terminal_color_13 = variant.palette.magenta.fg
        vim.g.terminal_color_14 = variant.palette.cyan.fg
        vim.g.terminal_color_15 = variant.palette.white.fg
    end

    if variant.guicursor == false then
        return
    end

    if type(variant.guicursor) == "string" then
        vim.opt.guicursor = variant.guicursor
    else
        if not vim.o.guicursor:find("Cursor") then
            initial_guicursor = vim.o.guicursor
        end
        vim.opt.guicursor = apply_cursor_hl(initial_guicursor, "Cursor")
    end
end

return M
