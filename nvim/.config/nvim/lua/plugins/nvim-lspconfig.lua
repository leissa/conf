return {
    "neovim/nvim-lspconfig",
    -- Commented out with the vimtex -> nvim-tex switch: nvim-tex drives texlab
    -- itself (build.onSave off), so it may no longer set diagnostics on unloaded
    -- buffers.  Re-enable if "Index out of bounds" from diagnostic.lua returns.
    --[[
    init = function()
        -- Workaround (nvim 0.12.4): vim.diagnostic's underline handler is the only one that
        -- doesn't clamp to the buffer, so a diagnostic past EOF makes nvim_buf_get_lines throw
        -- "Index out of bounds" (diagnostic.lua:1845). The signs and virtual_text handlers do
        -- clamp. This bites with texlab, which sets log-derived diagnostics on *unloaded*
        -- buffers; the error then surfaces on BufRead when the file is finally opened.
        local underline = vim.diagnostic.handlers.underline
        vim.diagnostic.handlers.underline = {
            hide = underline.hide,
            show = function(ns, bufnr, diagnostics, opts)
                local function show()
                    local last = vim.api.nvim_buf_line_count(bufnr) - 1
                    local clamped = {}
                    for i, d in ipairs(diagnostics) do
                        if d.lnum > last or (d.end_lnum or d.lnum) > last then
                            d = vim.deepcopy(d)
                            d.lnum = math.min(d.lnum, last)
                            d.end_lnum = last
                            d.end_col = #(vim.api.nvim_buf_get_lines(bufnr, last, last + 1, false)[1] or "")
                        end
                        clamped[i] = d
                    end
                    underline.show(ns, bufnr, clamped, opts)
                end
                -- an unloaded buffer reports 0 lines, so defer instead of clamping everything away
                if vim.api.nvim_buf_is_loaded(bufnr) then
                    show()
                else
                    vim.api.nvim_create_autocmd("BufRead", { buffer = bufnr, once = true, callback = show })
                end
            end,
        }
    end,
]]
    opts = function(_, opts)
        opts.inlay_hints = vim.tbl_deep_extend("force", opts.inlay_hints or {}, { enabled = false })
        opts.diagnostics = vim.tbl_deep_extend("force", opts.diagnostics or {}, { virtual_text = false })
        -- prefer the nearest .clangd/CMakePresets.json over .git (e.g. cgray inside the cg repo)
        local clangd = opts.servers and opts.servers.clangd
        if clangd and clangd.root_markers then
            clangd.root_markers = vim.list_extend({ ".clangd", "CMakePresets.json" }, clangd.root_markers)
        end
    end,
}
