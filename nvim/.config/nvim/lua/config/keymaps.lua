-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = LazyVim.safe_keymap_set
local del = vim.keymap.del

map("n", "<C-l>", "<cmd>nohlsearch<cr>", { silent = true, desc = "clear search highlighting" })
map("n", "Q", "@q")

-- Alternative for Home, Middle, Low
map({ "n", "v" }, "gh", "<S-h>", { desc = "Go Home" })
map({ "n", "v" }, "gm", "<S-m>", { desc = "Go Middle" })
map({ "n", "v" }, "gl", "<S-l>", { desc = "Go Low" })

-- Alternative for brackets in normal/visual mode
-- map({ "n", "v" }, "ö", "[", { desc = "[" })
-- map({ "n", "v" }, "ä", "]", { desc = "]" })

-- CLI/Window
map("n", "q:", "<Nop>", { desc = "Do *Not* open Commandline-Window" })
map("n", "q::", "q:", { desc = "Open Commandline-Window" })
map("c", "<c-j>", "<Down>")
map("c", "<c-k>", "<Up>")

-- Buffers
map("n", "<M-h>", "<cmd>BufferLineMovePrev<cr>", { desc = "Move Buffer Prev" })
map("n", "<M-l>", "<cmd>BufferLineMoveNext<cr>", { desc = "Move Buffer Next" })

-- Toggle inline images/math (snacks.image has no toggles of its own)
do
    local function redraw()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            pcall(vim.api.nvim_exec_autocmds, "WinScrolled", { group = "snacks.image.inline." .. buf, buffer = buf })
        end
    end

    local images = true
    local find_visible = Snacks.image.doc.find_visible
    Snacks.image.doc.find_visible = function(buf, cb)
        if images then return find_visible(buf, cb) end
        cb({}) -- no matches -> the inline renderer closes the visible images
    end

    Snacks.toggle.new({
        id = "image",
        name = "Inline Images",
        get = function() return images end,
        set = function(state) images = state; redraw() end,
    }):map("<leader>ui") -- replaces LazyVim's "Inspect Pos"

    -- math is rendered by snacks (typst/tex/...) and by fk_markdown (markdown); both default to off
    -- (see plugins/snacks.lua and plugins/markdown.lua)
    Snacks.toggle.new({
        id = "image_math",
        name = "Inline Math",
        get = function() return Snacks.image.config.math.enabled end,
        set = function(state)
            Snacks.image.config.math.enabled = state -- checked by snacks on every lookup
            redraw()
            if package.loaded["fk_markdown"] then
                local fk = require("fk_markdown.state")
                fk.config.latex.enabled = state -- new buffers
                for _, cfg in pairs(fk.cache) do -- existing buffers have their own copy
                    cfg.latex.enabled = state
                end
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    if fk.cache[buf] then
                        require("fk_markdown.core.ui").update(buf, win, "UserCommand", true)
                    end
                end
            end
        end,
    }):map("<leader>um")
end

-- remove LazyVim's "better indenting"
del("v", "<")
del("v", ">")
