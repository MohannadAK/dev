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
            },
            layout = {
                preset = "classic", -- Use v3 preset
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
            show_keys = true,
            triggers = { "<leader>" },
            disable = {
                ft = {},
                bt = {},
            },
            debug = false,
        })

        -- Default vim motions
        wk.add({
            { "a", desc = "Append after cursor" },
            { "A", desc = "Append at end of line" },
            { "b", desc = "Back to beginning of word" },
            { "B", desc = "Back to beginning of WORD" },
            { "c", desc = "Change text" },
            { "C", desc = "Change to end of line" },
            { "d", desc = "Delete text" },
            { "D", desc = "Delete to end of line" },
            { "f", desc = "Find character forward" },
            { "F", desc = "Find character backward" },
            { "g", desc = "Go to commands prefix" },
            { "G", desc = "Go to end of file" },
            { "h", desc = "Move left" },
            { "H", desc = "Move to top of screen" },
            { "i", desc = "Insert before cursor" },
            { "I", desc = "Insert at beginning of line" },
            { "j", desc = "Move down" },
            { "J", "mzJ`z", desc = "Join Lines (Keep Cursor Position)" },
            { "k", desc = "Move up" },
            { "K", desc = "Lookup keyword" },
            { "l", desc = "Move right" },
            { "L", desc = "Move to bottom of screen" },
            { "m", desc = "Set mark" },
            { "M", desc = "Move to middle of screen" },
            { "n", "nzzzv", desc = "Next Search Result (Center Cursor)" },
            { "N", "Nzzzv", desc = "Previous Search Result (Center Cursor)" },
            { "o", desc = "Open line below" },
            { "O", desc = "Open line above" },
            { "p", desc = "Paste after cursor" },
            { "P", desc = "Paste before cursor" },
            { "r", desc = "Replace character" },
            { "R", desc = "Replace mode" },
            { "s", desc = "Substitute character" },
            { "S", desc = "Substitute line" },
            { "t", desc = "Till character forward" },
            { "T", desc = "Till character backward" },
            { "u", desc = "Undo" },
            { "U", desc = "Undo line" },
            { "v", desc = "Visual mode" },
            { "V", desc = "Visual line mode" },
            { "w", desc = "Forward to start of word" },
            { "W", desc = "Forward to start of WORD" },
            { "x", desc = "Delete character" },
            { "X", desc = "Delete character backward" },
            { "y", desc = "Yank text" },
            { "Y", desc = "Yank line" },
            { "z", desc = "View commands prefix" },
            { "Z", desc = "Save and quit commands" },
            { "=ap", "ma=ap'a", desc = "Format Paragraph (Keep Position)" },
            { "<C-d>", "<C-d>zz", desc = "Half-Page Down (Center Cursor)" },
            { "<C-u>", "<C-u>zz", desc = "Half-Page Up (Center Cursor)" },
            { "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", desc = "Open Tmux Sessionizer" },
            { "<C-k>", "<cmd>cnext<CR>zz", desc = "Next Quickfix Item" },
            { "<C-j>", "<cmd>cprev<CR>zz", desc = "Previous Quickfix Item" },
            { "Q", "<nop>", desc = "Disabled" },
            { "<F5>", "<cmd>lua require'dap'.continue()<CR>", desc = "Continue Debug" },
            { "<F9>", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", desc = "Toggle Breakpoint" },
            { "<F10>", "<cmd>lua require'dap'.step_over()<CR>", desc = "Step Over" },
            { "<F11>", "<cmd>lua require'dap'.step_into()<CR>", desc = "Step Into" },
        })

        -- Leader key mappings
        wk.add({
            { "<leader>", group = "Leader" },
            { "<leader><leader>", ":so<cr>", desc = "Source Current File" },
            { "<leader>Y", [["+Y]], desc = "Yank Line to System Clipboard" },
            { "<leader>p", group = "Project" },
            { "<leader>pv", vim.cmd.Ex, desc = "Open Netrw Explorer" },
            { "<leader>t", group = "Test" },
            { "<leader>tf", "<Plug>PlenaryTestFile", desc = "Test File" },
            { "<leader>v", group = "Vim With Me" },
            { "<leader>vw", group = "With Me" },
            { "<leader>vwm", function()
                local ok, vim_with_me = pcall(require, "vim-with-me")
                if ok then
                    vim_with_me.StartVimWithMe()
                else
                    vim.notify("vim-with-me plugin not available", vim.log.levels.WARN)
                end
            end, desc = "Start Vim With Me" },
            { "<leader>vwn", function()
                local ok, vim_with_me = pcall(require, "vim-with-me")
                if ok then
                    vim_with_me.StopVimWithMe()
                else
                    vim.notify("vim-with-me plugin not available", vim.log.levels.WARN)
                end
            end, desc = "Stop Vim With Me" },
            { "<leader>s", group = "Substitute" },
            { "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "Substitute Word" },
            { "<leader>y", [["+y]], desc = "Yank to System Clipboard" },
            { "<leader>d", [["_d]], desc = "Delete without Copying" },
            { "<leader>f", function()
                local ok, conform = pcall(require, "conform")
                if ok then
                    conform.format({ bufnr =  W0 })
                else
                    vim.notify("conform plugin not available", vim.log.levels.WARN)
                end
            end, desc = "Format Buffer" },
            { "<leader>k", "<cmd>lnext<CR>zz", desc = "Next Location List Item" },
            { "<leader>j", "<cmd>lprev<CR>zz", desc = "Previous Location List Item" },
            { "<leader>x", "<cmd>!chmod +x %<CR>", desc = "Make Current File Executable" },
            { "<leader>e", group = "Error Handling (Go)" },
            { "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", desc = "Return Error" },
            { "<leader>ea", [[oassert.NoError(err, "")<Esc>F";a]], desc = "Assert No Error" },
            { "<leader>ef", [[oif err != nil {<CR>}<Esc>Olog.Fatalf("error: %s\n", err.Error())<Esc>jj]], desc = "Fatal Error" },
            { "<leader>el", [[oif err != nil {<CR>}<Esc>O.logger.Error("error", "error", err)<Esc>F.;i]], desc = "Log Error" },
            { "<leader>c", group = "Cellular Automaton" },
            { "<leader>ca", function()
                local ok, ca = pcall(require, "cellular-automaton")
                if ok then
                    ca.start_animation("make_it_rain")
                else
                    vim.notify("cellular-automaton plugin not available", vim.log.levels.WARN)
                end
            end, desc = "Make It Rain" },
            { "<leader>z", group = "LSP" },
            { "<leader>zi", "<cmd>LspRestart<cr>", desc = "Restart LSP" },
        })

        -- Visual mode mappings
        wk.add({
            { "J", ":m '>+1<CR>gv=gv", desc = "Move Selection Down", mode = "v" },
            { "K", ":m '<-2<CR>gv=gv", desc = "Move Selection Up", mode = "v" },
            { "<leader>p", [["_dP]], desc = "Paste Without Copying", mode = "v" },
            { "<leader>y", [["+y]], desc = "Yank to System Clipboard", mode = "v" },
            { "<leader>d", [["_d]], desc = "Delete without Copying", mode = "v" },
        })

        -- Insert mode mappings
        wk.add({
            { "<C-c>", "<Esc>", desc = "Exit Insert Mode", mode = "i" },
        })
    end,
}
