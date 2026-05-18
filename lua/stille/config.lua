local M = {}

---@class StilleConfig
---@field transparent? boolean
---@field terminal_colors? boolean
---@field color_overrides? table<string, table>
---@field comment_italic? boolean
---@field guicursor? string|boolean

---@type StilleConfig
M.options = {
    transparent = false,
    terminal_colors = true,
    color_overrides = {},
    comment_italic = true,
    guicursor = true,
}

---@param opts? StilleConfig
function M.setup(opts)
    M.options = vim.tbl_deep_extend("force", M.options, opts or {})
end

return M
