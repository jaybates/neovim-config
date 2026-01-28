-- =============================================================================
-- nvim-cmp Completion Engine Configuration
-- =============================================================================
-- nvim-cmp is a completion engine for Neovim written in Lua
-- It provides intelligent code completion with multiple sources

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Load when entering insert mode
  dependencies = {
    -- =============================================================================
    -- COMPLETION SOURCES
    -- =============================================================================
    "hrsh7th/cmp-buffer",     -- Buffer text completion
    "hrsh7th/cmp-path",       -- File system path completion
    "hrsh7th/cmp-nvim-lsp",   -- LSP completion source
    "hrsh7th/cmp-cmdline",    -- Command line completion
    
    -- =============================================================================
    -- SNIPPET ENGINE
    -- =============================================================================
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*", -- Use latest v2.x version
      build = "make install_jsregexp", -- Install JS regexp support
    },
    "saadparwaiz1/cmp_luasnip", -- LuaSnip integration for nvim-cmp
    "rafamadriz/friendly-snippets", -- Collection of useful snippets
    
    -- =============================================================================
    -- UI ENHANCEMENTS
    -- =============================================================================
    "onsails/lspkind.nvim", -- VS Code-like pictograms in completion menu
  },
  
  config = function()
    -- =============================================================================
    -- PLUGIN IMPORTS
    -- =============================================================================
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    -- =============================================================================
    -- SNIPPET CONFIGURATION
    -- =============================================================================
    -- Load VSCode-style snippets from friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()
    
    -- Load custom snippets (if any)
    -- require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets/" })

    -- =============================================================================
    -- COMPLETION SETUP
    -- =============================================================================
    cmp.setup({
      -- =============================================================================
      -- COMPLETION BEHAVIOR
      -- =============================================================================
      completion = {
        completeopt = "menu,menuone,preview,noselect", -- Better completion behavior
      },
      
      -- =============================================================================
      -- SNIPPET ENGINE INTEGRATION
      -- =============================================================================
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Expand snippets
        end,
      },
      
      -- =============================================================================
      -- KEY MAPPINGS
      -- =============================================================================
      mapping = cmp.mapping.preset.insert({
        -- Navigation
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- Previous suggestion
        ["<C-j>"] = cmp.mapping.select_next_item(), -- Next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),    -- Scroll documentation up
        ["<C-f>"] = cmp.mapping.scroll_docs(4),     -- Scroll documentation down
        
        -- Completion control
        ["<C-Space>"] = cmp.mapping.complete(), -- Show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(),        -- Close completion window
        ["<CR>"] = cmp.mapping.confirm({ 
          select = false -- Don't select first item by default
        }),
        
        -- Snippet navigation
        ["<C-l>"] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { "i", "s" }),
        ["<C-h>"] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { "i", "s" }),
      }),
      
      -- =============================================================================
      -- COMPLETION SOURCES
      -- =============================================================================
      sources = cmp.config.sources({
        { name = "nvim_lsp", priority = 1000 }, -- LSP completions (highest priority)
        { name = "luasnip", priority = 750 },   -- Snippet completions
        { name = "buffer", priority = 500 },    -- Buffer text completions
        { name = "path", priority = 250 },      -- File path completions
      }),

      -- =============================================================================
      -- FORMATTING & APPEARANCE
      -- =============================================================================
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text", -- Show both symbol and text
          maxwidth = 50,        -- Maximum width of completion menu
          ellipsis_char = "...", -- Ellipsis for truncated text
          before = function(entry, vim_item)
            return vim_item
          end,
        }),
      },
      
      -- =============================================================================
      -- WINDOW CONFIGURATION
      -- =============================================================================
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
      
      -- =============================================================================
      -- EXPERIMENTAL FEATURES
      -- =============================================================================
      experimental = {
        ghost_text = true, -- Show ghost text for better UX
      },
    })

    -- =============================================================================
    -- COMMAND LINE COMPLETION
    -- =============================================================================
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
        { name = "cmdline" },
      }),
    })

    -- =============================================================================
    -- SEARCH COMPLETION
    -- =============================================================================
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })
  end,
}