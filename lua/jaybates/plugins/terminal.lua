-- =============================================================================
-- Terminal Integration Configuration
-- =============================================================================
-- ToggleTerm provides a powerful terminal integration for Neovim
-- Supports floating terminals, multiple terminals, and smart positioning

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
        -- =============================================================================
        -- PLUGIN IMPORTS
        -- =============================================================================
        local toggleterm = require("toggleterm")

        -- =============================================================================
        -- TERMINAL CONFIGURATION
        -- =============================================================================
        toggleterm.setup({
            -- =============================================================================
            -- GENERAL SETTINGS
            -- =============================================================================
            size = function(term)
                if term.direction == "horizontal" then
                    return 15
                elseif term.direction == "vertical" then
                    return vim.o.columns * 0.4
                end
                return 20
            end,
            open_mapping = [[<c-\>]], -- Open terminal with Ctrl+\
            hide_numbers = true, -- Hide the number column in toggleterm buffers
            shade_filetypes = {}, -- Filetypes that are shaded
            shade_terminals = true, -- Shade the terminal background
            shading_factor = 2, -- The degree by which to darken the terminal
            start_in_insert = true, -- Start in insert mode
            insert_mappings = true, -- Whether or not the open mapping applies in insert mode
            persist_size = true, -- If true, the terminal size will be persisted
            direction = "float", -- The direction for the terminal
            close_on_exit = true, -- Close the terminal window when the process exits
            shell = vim.o.shell, -- Change the default shell
            auto_scroll = true, -- Automatically scroll to the bottom on terminal output

            -- =============================================================================
            -- FLOATING TERMINAL CONFIGURATION
            -- =============================================================================
            float_opts = {
                border = "curved", -- The border style
                width = math.floor(vim.o.columns * 0.8), -- Width of the floating window
                height = math.floor(vim.o.lines * 0.8), -- Height of the floating window
                winblend = 3, -- The degree of transparency
                -- Note: highlights option removed - it may cause "Expected Lua table" errors
                -- Border and background colors are handled by the colorscheme
            },

            -- =============================================================================
            -- WINBAR CONFIGURATION
            -- =============================================================================
            winbar = {
                enabled = false, -- Enable/disable the winbar
                name_formatter = function(term) -- Function to customize the terminal name
                    return term.name
                end,
            },
        })

        -- =============================================================================
        -- CUSTOM TERMINAL FUNCTIONS
        -- =============================================================================
        
        -- Function to create a new terminal
        local function new_terminal()
            local Terminal = require("toggleterm.terminal").Terminal
            return Terminal:new({
                direction = "float",
                float_opts = {
                    border = "curved",
                },
            })
        end

        -- Function to create a horizontal terminal
        local function new_horizontal_terminal()
            local Terminal = require("toggleterm.terminal").Terminal
            return Terminal:new({
                direction = "horizontal",
                size = 15,
            })
        end

        -- Function to create a vertical terminal
        local function new_vertical_terminal()
            local Terminal = require("toggleterm.terminal").Terminal
            return Terminal:new({
                direction = "vertical",
                size = vim.o.columns * 0.4,
            })
        end

        -- Function to create a tab terminal
        local function new_tab_terminal()
            local Terminal = require("toggleterm.terminal").Terminal
            return Terminal:new({
                direction = "tab",
            })
        end

        -- =============================================================================
        -- SPECIALIZED TERMINALS
        -- =============================================================================
        
        -- Git terminal for git operations
        local git_terminal = new_terminal()
        local function git_terminal_toggle()
            git_terminal:toggle()
        end

        -- LazyGit terminal
        local lazygit_terminal = new_terminal()
        local function lazygit_toggle()
            lazygit_terminal:toggle()
        end

        -- Node.js REPL terminal
        local node_terminal = new_terminal()
        local function node_toggle()
            node_terminal:toggle()
        end

        -- Python REPL terminal
        local python_terminal = new_terminal()
        local function python_toggle()
            python_terminal:toggle()
        end

        -- =============================================================================
        -- KEY MAPPINGS
        -- =============================================================================
        
        -- Basic terminal operations
        vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
        vim.keymap.set("n", "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", { desc = "Toggle floating terminal" })
        vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", { desc = "Toggle horizontal terminal" })
        vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", { desc = "Toggle vertical terminal" })
        vim.keymap.set("n", "<leader>tT", "<cmd>ToggleTerm direction=tab<cr>", { desc = "Toggle tab terminal" })

        -- Multiple terminals
        vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm<cr>", { desc = "Toggle terminal 1" })
        vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm<cr>", { desc = "Toggle terminal 2" })
        vim.keymap.set("n", "<leader>t3", "<cmd>3ToggleTerm<cr>", { desc = "Toggle terminal 3" })
        vim.keymap.set("n", "<leader>t4", "<cmd>4ToggleTerm<cr>", { desc = "Toggle terminal 4" })

        -- Specialized terminals
        vim.keymap.set("n", "<leader>tg", git_terminal_toggle, { desc = "Toggle git terminal" })
        vim.keymap.set("n", "<leader>tl", lazygit_toggle, { desc = "Toggle lazygit" })
        vim.keymap.set("n", "<leader>tn", node_toggle, { desc = "Toggle node REPL" })
        vim.keymap.set("n", "<leader>tp", python_toggle, { desc = "Toggle python REPL" })

        -- Terminal navigation (already in keyremaps.lua but adding more)
        vim.keymap.set("t", "<C-w>", "<C-\\><C-n><C-w>", { desc = "Window navigation from terminal" })
        vim.keymap.set("t", "<C-q>", "<C-\\><C-n>:q<cr>", { desc = "Quit from terminal" })

        -- =============================================================================
        -- AUTOCOMMANDS
        -- =============================================================================
        
        -- Auto-close terminal on successful exit
        vim.api.nvim_create_autocmd("TermOpen", {
            pattern = "term://*",
            callback = function()
                vim.opt_local.number = false
                vim.opt_local.relativenumber = false
                vim.opt_local.signcolumn = "no"
            end,
        })

        -- =============================================================================
        -- USER COMMANDS
        -- =============================================================================
        
        vim.api.nvim_create_user_command("Terminal", function(opts)
            if opts.args == "" then
                toggleterm.toggle()
            else
                toggleterm.exec(opts.args)
            end
        end, {
            nargs = "?",
            desc = "Open terminal or execute command",
            complete = function()
                return { "float", "horizontal", "vertical", "tab" }
            end,
        })

        vim.api.nvim_create_user_command("TerminalNew", function(opts)
            local direction = opts.args ~= "" and opts.args or "float"
            local Terminal = require("toggleterm.terminal").Terminal
            local term = Terminal:new({ direction = direction })
            term:toggle()
        end, {
            nargs = "?",
            desc = "Create new terminal",
            complete = function()
                return { "float", "horizontal", "vertical", "tab" }
            end,
        })

        -- =============================================================================
        -- INTEGRATION WITH OTHER PLUGINS
        -- =============================================================================
        
        -- Integration with telescope
        vim.api.nvim_create_autocmd("User", {
            pattern = "TelescopePreviewerLoaded",
            callback = function()
                vim.opt_local.number = true
            end,
        })

        -- Integration with LSP
        vim.api.nvim_create_autocmd("LspAttach", {
            callback = function()
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if client and client.name == "pyright" then
                    -- Python-specific terminal setup
                    python_terminal:spawn()
                elseif client and (client.name == "ts_ls" or client.name == "typescript-language-server") then
                    -- TypeScript-specific terminal setup
                    node_terminal:spawn()
                end
            end,
        })
    end,
}
