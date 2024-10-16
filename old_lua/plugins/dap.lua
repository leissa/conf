---@param config {args?:string[]|fun():string[]?}
local function get_args(config)
    local args = type(config.args) == "function" and (config.args() or {}) or config.args or {}
    config = vim.deepcopy(config)
    ---@cast args string[]
    config.args = function()
        local new_args = vim.fn.input("Run with args: ", table.concat(args, " ")) --[[@as string]]
        return vim.split(vim.fn.expand(new_args) --[[@as string]], " ")
    end
    return config
end

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- fancy UI for the debugger
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            -- stylua: ignore
            keys = {
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
                { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",  mode = { "n", "v" } },
            },
            opts = {},
            config = function(_, opts)
                -- setup dap config by VsCode launch.json file
                -- require("dap.ext.vscode").load_launchjs()
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open({})
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close({})
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close({})
                end
            end,
        },

        -- virtual text for the debugger
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },

    },

    opts = function()
        local dap = require("dap")
        dap.adapters["codelldb"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = {
                    "--port",
                    "${port}",
                },
            },
        }
        dap.adapters["gdb"] = {
            id = 'gdb',
            type = 'executable',
            command = 'gdb',
            args = { '--quiet', '--interpreter=dap' },
        }

        -- This requires special handling of 'run_last', see
        -- https://github.com/mfussenegger/nvim-dap/issues/1025#issuecomment-1695852355
        dap.configurations["c"] = {
            {
                name = 'Run executable (GDB)',
                type = 'gdb',
                request = 'launch',
                program = function()
                    local path = vim.fn.input({
                        prompt = 'Path to executable: ',
                        default = vim.fn.getcwd() .. '/',
                        completion = 'file',
                    })

                    return (path and path ~= '') and path or dap.ABORT
                end,
            },
            -- {
            --     name = 'Run executable with arguments (GDB)',
            --     type = 'gdb',
            --     request = 'launch',
            --     program = function()
            --         local path = vim.fn.input({
            --             prompt = 'Path to executable: ',
            --             default = vim.fn.getcwd() .. '/',
            --             completion = 'file',
            --         })
            --
            --         return (path and path ~= '') and path or dap.ABORT
            --     end,
            --     args = function()
            --         local args_str = vim.fn.input({
            --             prompt = 'Arguments: ',
            --         })
            --         return vim.split(args_str, ' +')
            --     end,
            -- },
            -- {
            --     name = 'Attach to process (GDB)',
            --     type = 'gdb',
            --     request = 'attach',
            --     processId = require('dap.utils').pick_process,
            -- },
        }
        dap.configurations["cpp"] = dap.configurations["c"]
    end,

    -- stylua: ignore
    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue/Run" },
        { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
        { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },

    config = function()
        vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

        local icons = require 'icons'
        for name, sign in pairs(icons.dap) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define(
                "Dap" .. name,
                { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
            )
        end
    end,
}
