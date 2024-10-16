local function name2color(name)
    local col = vim.api.nvim_get_hl(0, { name = name, link = false }).fg
    local res = col and string.format("#%06x", col) or nil
    return res and { fg = res } or nil
end

local icons = require 'icons'

return {
    {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        build = ":Copilot auth",
        opts = {
            suggestion = { enabled = false },
            panel = { enabled = false },
            filetypes = {
                markdown = true,
                help = true,
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        optional = true,
        opts = function(_, opts)
            local colors = {
                [""] = name2color("Special"),
                ["Normal"] = name2color("Special"),
                ["Warning"] = name2color("DiagnosticError"),
                ["InProgress"] = name2color("DiagnosticWarn"),
            }
            table.insert(opts.sections.lualine_x, 2, {
                function()
                    local icon = icons.kinds.Copilot
                    local status = require("copilot.api").status.data
                    return icon .. (status.message or "")
                end,
                cond = function()
                    if not package.loaded["copilot"] then
                        return false
                    end
                    -- local ok, clients = pcall(LazyVim.lsp.get_clients, { name = "copilot", bufnr = 0 })
                    -- if not ok then
                    --     return false
                    -- end
                    -- return ok and #clients > 0
                    return true
                end,
                color = function()
                    if not package.loaded["copilot"] then
                        return
                    end
                    local status = require("copilot.api").status.data
                    return colors[status.status] or colors[""]
                end,
            })
        end,
    },
}
