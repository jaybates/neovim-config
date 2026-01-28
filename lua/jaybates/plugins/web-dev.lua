-- =============================================================================
-- Web Development Plugins Configuration
-- =============================================================================
-- Essential plugins for modern web development
-- Includes React, TypeScript, CSS, and other web technologies

return {
  -- =============================================================================
  -- REACT & TYPESCRIPT SUPPORT
  -- =============================================================================
  {
    "pmizio/typescript-tools.nvim", -- Enhanced TypeScript support (actively maintained)
    dependencies = {
      "nvim-lua/plenary.nvim",
      "neovim/nvim-lspconfig",
    },
    -- typescript-tools.nvim is an actively maintained alternative to typescript.nvim
    -- It supports the new vim.lsp.config API and provides enhanced TypeScript features
    -- Features: better refactoring, improved diagnostics, code actions, and more
    -- Repository: https://github.com/pmizio/typescript-tools.nvim
    config = function()
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      
      require("typescript-tools").setup({
        -- LSP configuration
        on_attach = function(client, bufnr)
          -- Disable ts_ls formatting (use prettier instead)
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
        end,
        capabilities = cmp_nvim_lsp.default_capabilities(),
        -- TypeScript server settings
        settings = {
          tsserver_path = nil, -- Use mason-installed or system tsserver
          tsserver_plugins = {},
          tsserver_file_preferences = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          tsserver_format_options = {},
          tsserver_locale = "en",
          complete_function_calls = false,
          expose_as_code_action = {},
          handlers = {},
        },
      })
    end,
  },

  -- =============================================================================
  -- TAILWIND CSS SUPPORT
  -- =============================================================================
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    dependencies = { "nvim-cmp" },
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  -- =============================================================================
  -- CSS & STYLING
  -- =============================================================================
  {
    "brenoprata10/nvim-highlight-colors",
    event = "VeryLazy",
    config = function()
      local ok, highlight_colors = pcall(require, "nvim-highlight-colors")
      if ok then
        highlight_colors.setup({
          render = "background", -- or "foreground" or "first_line"
          enable_named_colors = true,
          enable_tailwind = true,
        })
      end
    end,
  },

  -- =============================================================================
  -- HTML & MARKUP
  -- =============================================================================
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
    config = function()
      require("nvim-ts-autotag").setup({
        filetypes = {
          "html",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "svelte",
          "vue",
          "tsx",
          "jsx",
          "rescript",
          "xml",
          "php",
          "markdown",
          "astro",
          "glimmer",
          "handlebars",
          "hbs",
        },
      })
    end,
  },

  -- =============================================================================
  -- VUE.JS SUPPORT
  -- =============================================================================
  {
    "posva/vim-vue",
    event = "VeryLazy",
    config = function()
      vim.g.vue_pre_processors = "detect"
    end,
  },

  -- =============================================================================
  -- SVELTE SUPPORT
  -- =============================================================================
  {
    "evanleck/vim-svelte",
    event = "VeryLazy",
    config = function()
      vim.g.svelte_preprocessors = "typescript"
    end,
  },

  -- =============================================================================
  -- NODE.JS & NPM
  -- =============================================================================
  {
    "vuki656/package-info.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup({
        -- Highlights removed - using default colorscheme highlights
        -- The highlights option was causing "Expected Lua table" errors
        icons = {
          enable = true,
          style = {
            up_to_date = "|",
            outdated = "|",
          },
        },
        autostart = true,
        hide_up_to_date = false,
        hide_unstable_versions = false,
        package_manager = "npm",
      })
    end,
  },

  -- =============================================================================
  -- JSON & YAML SUPPORT
  -- =============================================================================
  {
    "b0o/schemastore.nvim",
    event = "VeryLazy",
    -- schemastore is used in nvim-lspconfig.lua for jsonls configuration
    -- No separate config needed here
  },

  -- =============================================================================
  -- MARKDOWN SUPPORT
  -- =============================================================================
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- =============================================================================
  -- GRAPHQL SUPPORT
  -- =============================================================================
  {
    "jparise/vim-graphql",
    event = "VeryLazy",
  },

  -- =============================================================================
  -- DOCKER SUPPORT
  -- =============================================================================
  {
    "ekalinin/Dockerfile.vim",
    event = "VeryLazy",
  },

  -- =============================================================================
  -- ENVIRONMENT FILES
  -- =============================================================================
  {
    "tpope/vim-dotenv",
    event = "VeryLazy",
  },
}
