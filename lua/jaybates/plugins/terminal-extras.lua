-- =============================================================================
-- Terminal Extras Configuration
-- =============================================================================
-- Additional terminal-related plugins for enhanced CLI experience

return {
    -- =============================================================================
    -- LAZYGIT INTEGRATION
    -- =============================================================================
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- Optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "Open LazyGit" })
            vim.keymap.set("n", "<leader>gc", "<cmd>LazyGitCurrentFile<cr>", { desc = "LazyGit current file" })
            vim.keymap.set("n", "<leader>gf", "<cmd>LazyGitFilter<cr>", { desc = "LazyGit filter" })
        end,
    },

    -- =============================================================================
    -- FLOATING TERMINAL ENHANCEMENTS
    -- =============================================================================
    {
        "voldikss/vim-floaterm",
        event = "VeryLazy",
        config = function()
            -- Floaterm configuration
            vim.g.floaterm_wintype = "floating"
            vim.g.floaterm_position = "center"
            vim.g.floaterm_width = 0.8
            vim.g.floaterm_height = 0.8
            vim.g.floaterm_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
            vim.g.floaterm_title = "Terminal $1/$2"
            vim.g.floaterm_autoclose = 1
            vim.g.floaterm_autoinsert = 1
            vim.g.floaterm_autohide = 1
            vim.g.floaterm_opener = "edit"

            -- Key mappings
            vim.keymap.set("n", "<leader>ft", "<cmd>FloatermToggle<cr>", { desc = "Toggle floaterm" })
            vim.keymap.set("n", "<leader>fn", "<cmd>FloatermNew<cr>", { desc = "New floaterm" })
            vim.keymap.set("n", "<leader>fk", "<cmd>FloatermKill<cr>", { desc = "Kill floaterm" })
            vim.keymap.set("n", "<leader>fp", "<cmd>FloatermPrev<cr>", { desc = "Previous floaterm" })
            vim.keymap.set("n", "<leader>fn", "<cmd>FloatermNext<cr>", { desc = "Next floaterm" })
            vim.keymap.set("n", "<leader>fs", "<cmd>FloatermShow<cr>", { desc = "Show floaterm" })
            vim.keymap.set("n", "<leader>fh", "<cmd>FloatermHide<cr>", { desc = "Hide floaterm" })

            -- Terminal mode mappings
            vim.keymap.set("t", "<C-\\>", "<cmd>FloatermToggle<cr>", { desc = "Toggle floaterm" })
        end,
    },

    -- =============================================================================
    -- TERMINAL BUFFER MANAGEMENT
    -- =============================================================================
    {
        "stevearc/overseer.nvim",
        event = "VeryLazy",
        config = function()
            local overseer = require("overseer")
            overseer.setup({
                -- Configuration for task runner
                task_list = {
                    direction = "right",
                    min_height = 25,
                    max_height = 25,
                    default_detail = 1,
                    bindings = {
                        ["q"] = function()
                            vim.cmd("OverseerClose")
                        end,
                        ["<cr>"] = function()
                            vim.cmd("OverseerRunAction")
                        end,
                        ["<C-e>"] = function()
                            vim.cmd("OverseerRunAction")
                        end,
                        ["o"] = function()
                            vim.cmd("OverseerRunAction")
                        end,
                        ["<C-v>"] = function()
                            vim.cmd("OverseerRunAction")
                        end,
                        ["<C-f>"] = function()
                            vim.cmd("OverseerRunAction")
                        end,
                    },
                },
            })

            -- Key mappings
            vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run task" })
            vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Toggle overseer" })
            vim.keymap.set("n", "<leader>oq", "<cmd>OverseerQuickAction<cr>", { desc = "Quick action" })
            vim.keymap.set("n", "<leader>oc", "<cmd>OverseerClose<cr>", { desc = "Close overseer" })
        end,
    },

    -- =============================================================================
    -- ENHANCED COMMAND LINE
    -- =============================================================================
    {
        "notjedi/nvim-rooter.lua",
        event = "VeryLazy",
        config = function()
            require("nvim-rooter").setup({
                rooter_patterns = { ".git", "package.json", "Cargo.toml", "pyproject.toml" },
                fallback_to_parent = true,
                update_cwd = true,
                notify = true,
            })
        end,
    },

    -- =============================================================================
    -- QUICK COMMAND EXECUTION
    -- =============================================================================
    {
        "mhinz/vim-startify",
        event = "VimEnter",
        config = function()
            -- Startify configuration for better startup experience
            vim.g.startify_lists = {
                { type = "files", header = { "   Recent files" } },
                { type = "dir", header = { "   Recent files in " .. vim.fn.getcwd() } },
                { type = "sessions", header = { "   Sessions" } },
                { type = "bookmarks", header = { "   Bookmarks" } },
                { type = "commands", header = { "   Commands" } },
            }

            vim.g.startify_commands = {
                { c = { "Check Health", ":checkhealth" } },
                { m = { "Mason", ":Mason" } },
                { s = { "Startify", ":Startify" } },
                { t = { "ToggleTerm", ":ToggleTerm" } },
                { g = { "LazyGit", ":LazyGit" } },
            }

            vim.g.startify_bookmarks = {
                { c = "~/.config/nvim" },
                { d = "~/Documents" },
                { p = "~/Projects" },
            }
        end,
    },
}
