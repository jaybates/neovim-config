-- =============================================================================
-- Treesitter Syntax Highlighting Configuration
-- =============================================================================
-- Treesitter provides fast and accurate syntax highlighting
-- It uses incremental parsing to provide better performance

return {
    "nvim-treesitter/nvim-treesitter",
    priority = 150, -- Before comment.nvim and nvim-ts-autotag (they depend on TS)
    event = {"BufReadPre", "BufNewFile"},
    lazy = true,
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
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = {},
                max_file_lines = 10000, -- Skip TS highlight for huge files (faster)
            },
            
            -- =============================================================================
            -- INDENTATION
            -- =============================================================================
            indent = {
                enable = true, -- Enable indentation
                disable = {}, -- Languages to disable indentation for
            },
            
            -- =============================================================================
            -- LANGUAGE PARSERS
            -- =============================================================================
            ensure_installed = {
                -- React, JS, Node, Web
                "html", "css", "javascript", "typescript", "tsx", "json", "yaml",
                -- Backend
                "lua", "python", "go", "php",
                -- Data & config
                "graphql", "xml", "toml", "dockerfile", "gitignore",
                -- Terraform (HCL)
                "hcl",
                -- Docs & scripting
                "markdown", "markdown_inline", "vim", "vimdoc", "bash", "comment", "query",
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
                enable = true,
                extended_mode = true,
                max_file_lines = 10000, -- Disable for large files (saves work)
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

        -- nvim-ts-autotag: use standalone setup (treesitter autotag block is deprecated in 1.0.0)
        require("nvim-ts-autotag").setup({})
    end
}
