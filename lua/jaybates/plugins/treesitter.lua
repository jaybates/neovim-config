-- =============================================================================
-- Treesitter Syntax Highlighting Configuration
-- =============================================================================
-- Treesitter provides fast and accurate syntax highlighting
-- It uses incremental parsing to provide better performance

return {
    "nvim-treesitter/nvim-treesitter",
    event = {"BufReadPre", "BufNewFile"}, -- Load on file read
    -- Note: build step removed - parsers are installed automatically via ensure_installed
    -- If you need to update parsers manually, run :TSUpdate after treesitter is loaded
    lazy = true, -- Lazy load for better performance
    dependencies = {
        "windwp/nvim-ts-autotag", -- Auto-close HTML/JSX tags
    },
    
    config = function()
        -- =============================================================================
        -- PLUGIN IMPORTS
        -- =============================================================================
        local treesitter = require("nvim-treesitter.configs")

        -- =============================================================================
        -- TREESITTER SETUP
        -- =============================================================================
        treesitter.setup({
            -- =============================================================================
            -- SYNTAX HIGHLIGHTING
            -- =============================================================================
            highlight = {
                enable = true, -- Enable syntax highlighting
                additional_vim_regex_highlighting = false, -- Disable regex highlighting
                disable = {}, -- Languages to disable highlighting for
            },
            
            -- =============================================================================
            -- INDENTATION
            -- =============================================================================
            indent = {
                enable = true, -- Enable indentation
                disable = {}, -- Languages to disable indentation for
            },
            
            -- =============================================================================
            -- AUTO-TAGGING
            -- =============================================================================
            autotag = {
                enable = true, -- Enable auto-tagging for HTML/JSX
            },
            
            -- =============================================================================
            -- LANGUAGE PARSERS
            -- =============================================================================
            ensure_installed = {
                -- Web Development
                "html", "css", "javascript", "typescript", "tsx", "json", "yaml",
                
                -- Backend Development
                "lua", "python", "go", "rust", "java", "c", "cpp",
                
                -- Markup & Documentation
                "markdown", "markdown_inline", "vim", "vimdoc",
                
                -- Configuration & Data
                "toml", "dockerfile", "gitignore", "graphql",
                
                -- Shell & Scripting
                "bash", "awk", "php",
                
                -- Additional Languages
                "kotlin", "xml", "dot", "comment", "query",
            },
            
            -- =============================================================================
            -- INCREMENTAL SELECTION
            -- =============================================================================
            incremental_selection = {
                enable = true, -- Enable incremental selection
                keymaps = {
                    init_selection = "<C-space>", -- Start selection
                    node_incremental = "<C-space>", -- Increment selection
                    scope_incremental = false, -- Disable scope incremental
                    node_decremental = "<bs>", -- Decrement selection
                },
            },
            
            -- =============================================================================
            -- FOLDING
            -- =============================================================================
            fold = {
                enable = true, -- Enable folding
                disable = {}, -- Languages to disable folding for
            },
            
            -- =============================================================================
            -- RAINBOW PARENTHESES
            -- =============================================================================
            rainbow = {
                enable = true, -- Enable rainbow parentheses
                extended_mode = true, -- Also highlight non-bracket delimiters
                max_file_lines = nil, -- Disable for large files
            },
            
            -- =============================================================================
            -- CONTEXT COMMENTING
            -- =============================================================================
            context_commentstring = {
                enable = true, -- Enable context-aware commenting
                enable_autocmd = false, -- Disable auto-commands
            },
            
            -- =============================================================================
            -- TEXT OBJECTS
            -- =============================================================================
            textobjects = {
                select = {
                    enable = true, -- Enable text object selection
                    lookahead = true, -- Look ahead for better selection
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer", -- Around function
                        ["if"] = "@function.inner", -- Inside function
                        ["ac"] = "@class.outer", -- Around class
                        ["ic"] = "@class.inner", -- Inside class
                    },
                },
                move = {
                    enable = true, -- Enable text object movement
                    set_jumps = true, -- Set jumps in jumplist
                    goto_next_start = {
                        ["]f"] = "@function.outer", -- Next function start
                        ["]c"] = "@class.outer", -- Next class start
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer", -- Next function end
                        ["]C"] = "@class.outer", -- Next class end
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer", -- Previous function start
                        ["[c"] = "@class.outer", -- Previous class start
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer", -- Previous function end
                        ["[C"] = "@class.outer", -- Previous class end
                    },
                },
            },
        })
    end
}
