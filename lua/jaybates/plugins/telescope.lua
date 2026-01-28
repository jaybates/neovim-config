-- =============================================================================
-- Telescope Fuzzy Finder Configuration
-- =============================================================================
-- Telescope is a highly extendable fuzzy finder over lists
-- Built on the latest awesome features from neovim core

return {
    'nvim-telescope/telescope.nvim',
    lazy = true, -- Load only when needed
    dependencies = {
        "nvim-lua/plenary.nvim", -- Required for telescope
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make", -- Build the native extension
        },
        "nvim-tree/nvim-web-devicons", -- Icons for telescope
        "folke/todo-comments.nvim", -- Todo comments integration
    },
    
    config = function()
        -- =============================================================================
        -- PLUGIN IMPORTS
        -- =============================================================================
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local transform_mod = require("telescope.actions.mt").transform_mod
        local trouble = require("trouble")
        local trouble_sources = require("trouble.sources.telescope")

        -- =============================================================================
        -- CUSTOM ACTIONS
        -- =============================================================================
        local custom_actions = transform_mod({
            open_trouble_qflist = function(prompt_bufnr)
                trouble.toggle("quickfix")
            end
        })

        -- =============================================================================
        -- TELESCOPE SETUP
        -- =============================================================================
        telescope.setup({
            -- =============================================================================
            -- DEFAULT CONFIGURATION
            -- =============================================================================
            defaults = {
                -- =============================================================================
                -- DISPLAY OPTIONS
                -- =============================================================================
                path_display = {"smart"}, -- Smart path display
                file_sorter = require("telescope.sorters").get_fzy_sorter,
                generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
                
                -- =============================================================================
                -- WINDOW CONFIGURATION
                -- =============================================================================
                winblend = 0, -- Window transparency
                border = {}, -- Border configuration
                borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
                color_devicons = true, -- Color file type icons
                use_less = true, -- Use less for paging
                set_env = { ["COLORTERM"] = "truecolor" }, -- Set environment variables
                
                -- =============================================================================
                -- PREVIEW CONFIGURATION
                -- =============================================================================
                preview = {
                    treesitter = {
                        disable = { "html", "css", "scss", "sass", "less", "json", "yaml", "toml" }
                    }
                },
                
                -- =============================================================================
                -- MAPPINGS
                -- =============================================================================
                mappings = {
                    i = {
                        -- Navigation
                        ["<C-k>"] = actions.move_selection_previous, -- Move to previous result
                        ["<C-j>"] = actions.move_selection_next,     -- Move to next result
                        ["<C-u>"] = actions.preview_scrolling_up,    -- Scroll preview up
                        ["<C-d>"] = actions.preview_scrolling_down,  -- Scroll preview down
                        
                        -- Actions
                        ["<C-q>"] = actions.send_selected_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-t>"] = trouble_sources.open,
                        ["<C-c>"] = actions.close, -- Close telescope
                        ["<C-x>"] = actions.delete_buffer, -- Delete buffer
                        ["<C-s>"] = actions.select_horizontal, -- Open in horizontal split
                        ["<C-v>"] = actions.select_vertical, -- Open in vertical split
                        ["<C-\\>"] = actions.select_tab, -- Open in new tab
                    },
                    n = {
                        ["<C-q>"] = actions.send_to_qflist + custom_actions.open_trouble_qflist,
                        ["<C-t>"] = trouble_sources.open,
                    },
                },
                
                -- =============================================================================
                -- PICKER CONFIGURATION
                -- =============================================================================
                pickers = {
                    find_files = {
                        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
                        hidden = true, -- Include hidden files
                        no_ignore = false, -- Respect .gitignore
                        follow = true, -- Follow symbolic links
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden" }
                        end,
                    },
                },
            },
            
            -- =============================================================================
            -- EXTENSIONS CONFIGURATION
            -- =============================================================================
            extensions = {
                fzf = {
                    fuzzy = true, -- Enable fuzzy search
                    override_generic_sorter = true, -- Override generic sorter
                    override_file_sorter = true, -- Override file sorter
                    case_mode = "smart_case", -- Case sensitivity
                },
            },
        })

        -- =============================================================================
        -- LOAD EXTENSIONS
        -- =============================================================================
        telescope.load_extension("fzf") -- Load fzf native extension
        
        -- =============================================================================
        -- KEY MAPPINGS
        -- =============================================================================
        -- Note: Key mappings are now handled in core/keymaps.lua for better organization
        -- This keeps the plugin configuration focused on setup rather than key bindings
    end
}

