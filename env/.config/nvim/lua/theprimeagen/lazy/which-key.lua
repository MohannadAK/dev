return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300

        local wk = require("which-key")

        wk.setup({
            plugins = {
                marks = true,
                registers = true,
                spelling = { enabled = false },
                presets = {
                    operators = true,
                    motions = true,
                    text_objects = true,
                    windows = true,
                    nav = true,
                    z = true,
                    g = true,
                },
            },
            win = {
                border = "rounded",
                padding = {1, 2, 1, 2},
                -- Removed winblend, position, and margin due to invalid key errors
            },
            layout = {
                height = { min = 4, max = 25 },
                width = { min = 20, max = 50 },
                spacing = 3,
                align = "left",
            },
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
            },
            show_help = true,
            triggers = { "<leader>" },
        })

        -- Register descriptions for default vim motions
        wk.register({
            a = "Append after cursor",
            A = "Append at end of line",
            b = "Back to beginning of word",
            B = "Back to beginning of WORD",
            c = "Change text",
            C = "Change to end of line",
            d = "Delete text",
            D = "Delete to end of line",
            f = "Find character forward",
            F = "Find character backward",
            g = "Go to commands prefix",
            G = "Go to end of file",
            h = "Move left",
            H = "Move to top of screen",
            i = "Insert before cursor",
            I = "Insert at beginning of line",
            j = "Move down",
            J = { "mzJ`z", "Join Lines (Keep Cursor Position)" },
            k = "Move up",
            K = "Lookup keyword",
            l = "Move right",
            L = "Move to bottom of screen",
            m = "Set mark",
            M = "Move to middle of screen",
            n = { "nzzzv", "Next Search Result (Center Cursor)" },
            N = { "Nzzzv", "Previous Search Result (Center Cursor)" },
            o = "Open line below",
            O = "Open line above",
            p = "Paste after cursor",
            P = "Paste before cursor",
            r = "Replace character",
            R = "Replace mode",
            s = "Substitute character",
            S = "Substitute line",
            t = "Till character forward",
            T = "Till character backward",
            u = "Undo",
            U = "Undo line",
            v = "Visual mode",
            V = "Visual line mode",
            w = "Forward to start of word",
            W = "Forward to start of WORD",
            x = "Delete character",
            X = "Delete character backward",
            y = "Yank text",
            Y = "Yank line",
            z = "View commands prefix",
            Z = "Save and quit commands",
            ["=ap"] = { "ma=ap'a", "Format Paragraph (Keep Position)" },
            ["<C-d>"] = { "<C-d>zz", "Half-Page Down (Center Cursor)" },
            ["<C-u>"] = { "<C-u>zz", "Half-Page Up (Center Cursor)" },
            ["<C-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Open Tmux Sessionizer" },
            ["<C-k>"] = { "<cmd>cnext<CR>zz", "Next Quickfix Item" },
            ["<C-j>"] = { "<cmd>cprev<CR>zz", "Previous Quickfix Item" },
            Q = { "<nop>", "Disabled" },
            -- Debug commands (assuming nvim-dap)
            ["<F5>"] = { "<cmd>lua require'dap'.continue()<CR>", "Continue Debug" },
            ["<F9>"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },
            ["<F10>"] = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
            ["<F11>"] = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
        })

        -- Leader key mappings
        wk.register({
            ["<leader>"] = {
                ["<leader>"] = { ":so<cr>", "Source Current File" },
                Y = { [["+Y]], "Yank Line to System Clipboard" },
                p = {
                    name = "Project",
                    v = { vim.cmd.Ex, "Open Netrw Explorer" },
                },
                t = {
                    name = "Test",
                    f = { "<Plug>PlenaryTestFile", "Test File" },
                },
                v = {
                    name = "Vim With Me",
                    w = {
                        name = "With Me",
                        m = {
                            function()
                                local ok, vim_with_me = pcall(require, "vim-with-me")
                                if ok then
                                    vim_with_me.StartVimWithMe()
                                else
                                    vim.notify("vim-with-me plugin not available", vim.log.levels.WARN)
                                end
                            end,
                            "Start Vim With Me"
                        },
                        n = {
                            function()
                                local ok, vim_with_me = pcall(require, "vim-with-me")
                                if ok then
                                    vim_with_me.StopVimWithMe()
                                else
                                    vim.notify("vim-with-me plugin not available", vim.log.levels.WARN)
                                end
                            end,
                            "Stop Vim With Me"
                        },
                    },
                },
                s = {
                    name = "Substitute",
                    [""] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Substitute Word" },
                },
                y = { [["+y]], "Yank to System Clipboard" },
                d = { [["_d]], "Delete without Copying" },
                f = {
                    function()
                        local ok, conform = pcall(require, "conform")
                        if ok then
                            conform.format({ bufnr = 0 })
                        else
                            vim.notify("conform plugin not available", vim.log.levels.WARN)
                        end
                    end,
                    "Format Buffer"
                },
                k = { "<cmd>lnext<CR>zz", "Next Location List Item" },
                j = { "<cmd>lprev<CR>zz", "Previous Location List Item" },
                x = { "<cmd>!chmod +x %<CR>", "Make Current File Executable" },
                e = {
                    name = "Error Handling (Go)",
                    e = { "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", "Return Error" },
                    a = { [[oassert.NoError(err, "")<Esc>F";a]], "Assert No Error" },
                    f = { [[oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\n", err.Error())<Esc>jj]], "Fatal Error" },
                    l = { [[oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i]], "Log Error" },
                },
                c = {
                    name = "Cellular Automaton",
                    a = {
                        function()
                            local ok, ca = pcall(require, "cellular-automaton")
                            if ok then
                                ca.start_animation("make_it_rain")
                            else
                                vim.notify("cellular-automaton plugin not available", vim.log.levels.WARN)
                            end
                        end,
                        "Make It Rain"
                    },
                },
                z = {
                    name = "LSP",
                    i = { "<cmd>LspRestart<cr>", "Restart LSP" },
                },
            },
        })

        -- Visual mode mappings
        wk.register({
            J = { ":m '>+1<CR>gv=gv", "Move Selection Down" },
            K = { ":m '<-2<CR>gv=gv", "Move Selection Up" },
            ["<leader>p"] = { [["_dP]], "Paste Without Copying" },
            ["<leader>y"] = { [["+y]], "Yank to System Clipboard" },
            ["<leader>d"] = { [["_d]], "Delete without Copying" },
        }, { mode = "v" })

        -- Insert mode mappings
        wk.register({
            ["<C-c>"] = { "<Esc>", "Exit Insert Mode" },
        }, { mode = "i" })
    end,
}
