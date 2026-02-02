-- =============================================================================
-- Catppuccin Colorscheme Configuration
-- =============================================================================
-- A beautiful, warm dark theme for Neovim with multiple variants
-- Supports many plugins and provides excellent syntax highlighting

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- Load this colorscheme first
    lazy = false,    -- Load immediately for better startup experience
    
    config = function()
        require("catppuccin").setup({
            -- =============================================================================
            -- THEME VARIANT
            -- =============================================================================
            flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
            
            -- =============================================================================
            -- BACKGROUND OPTIONS
            -- =============================================================================
            transparent_background = false, -- Set to true for transparent background
            show_end_of_buffer = false,     -- Show '~' characters after end of buffer
            
            -- =============================================================================
            -- TERMINAL INTEGRATION
            -- =============================================================================
            term_colors = false, -- Set terminal colors (useful for some terminals)
            
            -- =============================================================================
            -- INACTIVE WINDOW DIMming
            -- =============================================================================
            dim_inactive = {
                enabled = false,    -- Dim inactive windows
                shade = "dark",     -- Shade type: "dark" or "light"
                percentage = 0.15   -- Dimming percentage (0.0 to 1.0)
            },
            
            -- =============================================================================
            -- FONT STYLES
            -- =============================================================================
            no_italic = false,    -- Disable italic fonts
            no_bold = false,      -- Disable bold fonts
            no_underline = false, -- Disable underlined text
            
            -- =============================================================================
            -- SYNTAX HIGHLIGHTING STYLES
            -- =============================================================================
            styles = {
                comments = {"italic"},    -- Comment style
                conditionals = {"italic"}, -- Conditional statements
                loops = {},               -- Loop constructs
                functions = {},           -- Function definitions
                keywords = {},            -- Language keywords
                strings = {},             -- String literals
                variables = {},           -- Variable names
                numbers = {},             -- Numeric literals
                booleans = {},            -- Boolean values
                properties = {},          -- Object properties
                types = {},               -- Type definitions
                operators = {}            -- Operators
            },
            
            -- =============================================================================
            -- COLOR CUSTOMIZATION
            -- =============================================================================
            color_overrides = {}, -- Override specific colors
            custom_highlights = {}, -- Add custom highlight groups
            
            -- =============================================================================
            -- PLUGIN INTEGRATIONS
            -- =============================================================================
            integrations = {
                -- Core Neovim plugins
                cmp = true,              -- nvim-cmp completion
                gitsigns = true,         -- Git signs in gutter
                nvimtree = true,         -- File explorer
                treesitter = true,       -- Syntax highlighting
                notify = false,          -- Notifications (disabled to avoid conflicts)
                
                -- Additional integrations
                alpha = true,            -- Startup screen
                bufferline = true,       -- Buffer line
                dap = true,              -- Debug Adapter Protocol
                dap_ui = true,           -- DAP UI
                diffview = true,         -- Diffview (git.lua)
                fzf = true,              -- fzf-lua fuzzy finder
                harpoon = true,          -- File marks
                indent_blankline = true,  -- Indent guides
                lsp_trouble = true,       -- LSP diagnostics
                mason = true,            -- LSP installer
                nvim_surround = true,    -- nvim-surround
                overseer = true,         -- Task runner (terminal-extras.lua)
                mini = {
                    enabled = true,      -- Mini plugins
                    indentscope_color = "" -- Indent scope color
                },
                native_lsp = {
                    enabled = true,      -- Native LSP
                    virtual_text = {
                        errors = {"italic"},
                        hints = {"italic"},
                        warnings = {"italic"},
                        information = {"italic"},
                    },
                    underlines = {
                        errors = {"underline"},
                        hints = {"underline"},
                        warnings = {"underline"},
                        information = {"underline"},
                    },
                },
                noice = true,            -- Enhanced UI
                telescope = true,        -- Fuzzy finder
                treesitter_context = true, -- Treesitter context
                which_key = true,        -- Key mapping helper
            }
        })

        -- Apply the colorscheme
        vim.cmd.colorscheme "catppuccin"
    end
}

