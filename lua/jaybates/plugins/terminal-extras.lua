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

}
