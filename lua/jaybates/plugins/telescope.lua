-- =============================================================================
-- Telescope Fuzzy Finder Configuration
-- =============================================================================
-- Telescope is a highly extendable fuzzy finder over lists
-- Built on the latest awesome features from neovim core

return {
    "nvim-telescope/telescope.nvim",
    lazy = true,
    cmd = "Telescope", -- Load when :Telescope or keymap runs Telescope command
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
        local action_state = require("telescope.actions.state")
        local transform_mod = require("telescope.actions.mt").transform_mod
        local sorters = require("telescope.sorters")
        -- Optional: trouble integration (only if trouble.nvim is loaded)
        local trouble_ok, trouble = pcall(require, "trouble")
        local trouble_sources_ok, trouble_sources = pcall(require, "trouble.sources.telescope")

        -- Open file in the main editing window (never in nvim-tree). Never use Telescope's
        -- window as target (it closes when Telescope closes). If no editor window exists,
        -- split horizontally so you get tree above, file below.
        local function open_in_main_win(prompt_bufnr)
            local entry = action_state.get_selected_entry(prompt_bufnr)
            if not entry or not entry.value then
                actions.close(prompt_bufnr)
                return
            end
            local path = entry.path or entry.value
            if type(path) ~= "string" then
                path = tostring(path)
            end
            path = vim.fn.fnamemodify(path, ":p")
            path = path:gsub("%s+$", "")
            if path == "" or vim.fn.isdirectory(path) == 1 then
                actions.close(prompt_bufnr)
                return
            end

            local picker_win = nil
            for _, w in ipairs(vim.api.nvim_list_wins()) do
                if vim.api.nvim_win_get_buf(w) == prompt_bufnr then
                    picker_win = w
                    break
                end
            end

            -- Find a real editor window (normal file buffer), never the Telescope picker
            local target_win = nil
            for _, w in ipairs(vim.api.nvim_list_wins()) do
                if w == picker_win then goto continue end
                local buf = vim.api.nvim_win_get_buf(w)
                local buftype = vim.api.nvim_buf_get_option(buf, "buftype")
                local ft = vim.api.nvim_buf_get_option(buf, "filetype")
                if (buftype == "" or buftype == "acwrite") and ft ~= "NvimTree" and ft ~= "nvimtree" then
                    target_win = w
                    break
                end
                ::continue::
            end

            actions.close(prompt_bufnr)
            local path_escaped = vim.fn.fnameescape(path)
            vim.schedule(function()
                if target_win and vim.api.nvim_win_is_valid(target_win) then
                    vim.api.nvim_set_current_win(target_win)
                    vim.cmd("edit " .. path_escaped)
                else
                    vim.cmd("split")
                    vim.cmd("edit " .. path_escaped)
                end
                vim.api.nvim_buf_set_option(vim.api.nvim_get_current_buf(), "buflisted", true)
            end)
        end

        -- =============================================================================
        -- CUSTOM ACTIONS (trouble only if available)
        -- =============================================================================
        local custom_actions = transform_mod(
            (trouble_ok and trouble) and {
                open_trouble_qflist = function()
                    trouble.toggle("quickfix")
                end,
            } or {}
        )

        -- =============================================================================
        -- TELESCOPE SETUP
        -- =============================================================================
        telescope.setup({
            -- =============================================================================
            -- DEFAULT CONFIGURATION
            -- =============================================================================
            defaults = {
                -- =============================================================================
                -- PERFORMANCE
                -- =============================================================================
                -- Skip heavy dirs so find_files and live_grep stay fast
                file_ignore_patterns = {
                    "node_modules", ".git/", "vendor/", "__pycache__/", ".next/", "dist/", "build/",
                    ".cache/", "%.pyc", "%.lock", ".sass-cache", ".terraform",
                },
                -- Cap results so the list renders quickly
                result_limit = 200,

                -- =============================================================================
                -- DISPLAY OPTIONS
                -- =============================================================================
                path_display = { "truncate" }, -- Slightly faster than "smart"
                file_sorter = sorters.get_fzy_sorter or sorters.get_generic_fuzzy_sorter,
                generic_sorter = sorters.get_generic_fuzzy_sorter,

                -- =============================================================================
                -- WINDOW CONFIGURATION (horizontal: results + prompt left, preview right)
                -- =============================================================================
                layout_strategy = "horizontal",
                layout_config = {
                    horizontal = {
                        preview_width = 0.55,
                        prompt_position = "bottom",
                    },
                },
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
                        ["<C-q>"] = (trouble_ok and custom_actions.open_trouble_qflist) and (actions.send_selected_to_qflist + custom_actions.open_trouble_qflist) or actions.send_selected_to_qflist,
                        ["<C-t>"] = (trouble_sources_ok and trouble_sources and trouble_sources.open) or actions.select_horizontal,
                        ["<C-c>"] = actions.close,
                        ["<C-x>"] = actions.delete_buffer,
                        ["<C-s>"] = actions.select_horizontal,
                        ["<C-v>"] = actions.select_horizontal,
                        ["<C-\\>"] = actions.select_horizontal,
                    },
                    n = {
                        ["<C-q>"] = (trouble_ok and custom_actions.open_trouble_qflist) and (actions.send_to_qflist + custom_actions.open_trouble_qflist) or actions.send_to_qflist,
                        ["<C-t>"] = (trouble_sources_ok and trouble_sources and trouble_sources.open) or actions.select_horizontal,
                    },
                },
                
                -- =============================================================================
                -- PICKER CONFIGURATION
                -- =============================================================================
                pickers = {
                    find_files = {
                        -- fd is fast; exclude heavy dirs so it doesn't even walk them
                        find_command = {
                            "fd", "--type", "f", "--strip-cwd-prefix",
                            "--hidden", "--follow",
                            "--exclude", "node_modules", "--exclude", ".git", "--exclude", "vendor",
                            "--exclude", "__pycache__", "--exclude", ".next", "--exclude", "dist",
                            "--exclude", "build", "--exclude", ".cache", "--exclude", ".terraform",
                        },
                        hidden = true,
                        no_ignore = false,
                        follow = true,
                        attach_mappings = function(prompt_bufnr, map)
                            map("i", "<CR>", function()
                                open_in_main_win(prompt_bufnr)
                            end)
                            map("n", "<CR>", function()
                                open_in_main_win(prompt_bufnr)
                            end)
                            return true
                        end,
                    },
                    oldfiles = {
                        attach_mappings = function(prompt_bufnr, map)
                            map("i", "<CR>", function()
                                open_in_main_win(prompt_bufnr)
                            end)
                            map("n", "<CR>", function()
                                open_in_main_win(prompt_bufnr)
                            end)
                            return true
                        end,
                    },
                    live_grep = {
                        -- Skip heavy dirs so ripgrep finishes faster
                        additional_args = function()
                            return {
                                "--hidden",
                                "--glob", "!node_modules/*",
                                "--glob", "!.git/*",
                                "--glob", "!vendor/*",
                                "--glob", "!__pycache__/*",
                                "--glob", "!.next/*",
                                "--glob", "!dist/*",
                                "--glob", "!build/*",
                            }
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

