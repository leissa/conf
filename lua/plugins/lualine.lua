local icons = require 'icons'
local norm = require 'lazy.core.util'.norm

function Color(name)
    local col = vim.api.nvim_get_hl(0, { name = name, link = false }).fg
    local res = col and string.format("#%06x", col) or nil
    return res and { fg = res } or nil
end

function Realpath(path)
    if path == "" or path == nil then
        return nil
    end
    path = vim.uv.fs_realpath(path) or path
    return norm(path)
end

function CWD()
    return Realpath(vim.uv.cwd()) or ""
end

function RootDir(opts)
    opts = vim.tbl_extend("force", {
        cwd = false,
        subdirectory = true,
        parent = true,
        other = true,
        icon = "󱉭 ",
        color = Color("Special"),
    }, opts or {})

    local function get()
        local cwd = CWD()
        -- local root = LazyVim.root.get({ normalize = true })
        local root = norm(Root())
        local name = vim.fs.basename(root)

        if root == cwd then
            -- root is cwd
            return opts.cwd and name
        elseif root:find(cwd, 1, true) == 1 then
            -- root is subdirectory of cwd
            return opts.subdirectory and name
        elseif cwd:find(root, 1, true) == 1 then
            -- root is parent directory of cwd
            return opts.parent and name
        else
            -- root and cwd are not related
            return opts.other and name
        end
    end

    return {
        function()
            return (opts.icon and opts.icon .. " ") .. get()
        end,
        cond = function()
            return type(get()) == "string"
        end,
        color = opts.color,
    }
end

function Format(component, text, hl_group)
    if not hl_group or hl_group == "" then
        return text
    end
    ---@type table<string, string>
    component.hl_cache = component.hl_cache or {}
    local lualine_hl_group = component.hl_cache[hl_group]
    if not lualine_hl_group then
        local utils = require("lualine.utils.utils")
        ---@type string[]
        local gui = vim.tbl_filter(function(x)
            return x
        end, {
            utils.extract_highlight_colors(hl_group, "bold") and "bold",
            utils.extract_highlight_colors(hl_group, "italic") and "italic",
        })

        lualine_hl_group = component:create_hl({
            fg = utils.extract_highlight_colors(hl_group, "fg"),
            gui = #gui > 0 and table.concat(gui, ",") or nil,
        }, "LV_" .. hl_group) --[[@as string]]
        component.hl_cache[hl_group] = lualine_hl_group
    end
    return component:format_hl(lualine_hl_group) .. text .. component:get_default_hl()
end

function PrettyPath(opts)
    opts = vim.tbl_extend("force", {
        relative = "cwd",
        modified_hl = "MatchParen",
        directory_hl = "",
        filename_hl = "Bold",
        modified_sign = "",
    }, opts or {})

    return function(self)
        local path = vim.fn.expand("%:p") --[[@as string]]

        if path == "" then
            return ""
        end

        local root = norm(Root())
        local cwd = CWD()

        if opts.relative == "cwd" and path:find(cwd, 1, true) == 1 then
            path = path:sub(#cwd + 2)
        else
            path = path:sub(#root + 2)
        end

        local sep = package.config:sub(1, 1)
        local parts = vim.split(path, "[\\/]")

        if #parts > 3 then
            parts = { parts[1], "…", parts[#parts - 1], parts[#parts] }
        end

        if opts.modified_hl and vim.bo.modified then
            parts[#parts] = parts[#parts] .. opts.modified_sign
            parts[#parts] = Format(self, parts[#parts], opts.modified_hl)
        else
            parts[#parts] = Format(self, parts[#parts], opts.filename_hl)
        end

        local dir = ""
        if #parts > 1 then
            dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
            dir = Format(self, dir .. sep, opts.directory_hl)
        end
        return dir .. parts[#parts]
    end
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'tokyonight',
            globalstatus = true,
            disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = {
                RootDir(),
                {
                    "diagnostics",
                    symbols = {
                        error = icons.diagnostics.Error,
                        warn  = icons.diagnostics.Warn,
                        info  = icons.diagnostics.Info,
                        hint  = icons.diagnostics.Hint,
                    },
                },
                { "filetype",  icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                { PrettyPath() },
            },
            lualine_x = {
                {
                    function() return require("noice").api.status.command.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
                    color = Color("Statement"),
                },
                {
                    function() return require("noice").api.status.mode.get() end,
                    cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    color = Color("Constant"),
                },
                {
                    function() return "  " .. require("dap").status() end,
                    cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
                    color = Color("Debug"),
                },
                {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = Color("Special"),
                },
                {
                    "diff",
                    symbols = {
                        added    = icons.git.added,
                        modified = icons.git.modified,
                        removed  = icons.git.removed,
                    },
                    source = function()
                        local gitsigns = vim.b.gitsigns_status_dict
                        if gitsigns then
                            return {
                                added = gitsigns.added,
                                modified = gitsigns.changed,
                                removed = gitsigns.removed,
                            }
                        end
                    end,
                },
            },
            lualine_y = {
                { "progress", separator = " ",                  padding = { left = 1, right = 0 } },
                { "location", padding = { left = 0, right = 1 } },
            },
            lualine_z = {
                function() return " " .. os.date("%R") end,
            },
        },
        extensions = { "neo-tree", "lazy" },
    },
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            vim.o.statusline = " " -- set an empty statusline till lualine loads
        else
            vim.o.laststatus = 0   -- hide the statusline on the starter page
        end
    end,
}
