return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        -- =============================================================================
        -- WEB DEVELOPMENT
        -- =============================================================================
        javascript = { "prettier", "eslint_d" },
        typescript = { "prettier", "eslint_d" },
        javascriptreact = { "prettier", "eslint_d" },
        typescriptreact = { "prettier", "eslint_d" },
        jsx = { "prettier", "eslint_d" },
        tsx = { "prettier", "eslint_d" },
        vue = { "prettier", "eslint_d" },
        svelte = { "prettier", "eslint_d" },
        
        -- =============================================================================
        -- STYLING
        -- =============================================================================
        css = { "prettier", "stylelint" },
        scss = { "prettier", "stylelint" },
        sass = { "prettier", "stylelint" },
        less = { "prettier", "stylelint" },
        stylus = { "prettier" },
        
        -- =============================================================================
        -- MARKUP
        -- =============================================================================
        html = { "prettier", "htmlhint" },
        htmldjango = { "prettier" },
        erb = { "prettier" },
        php = { "prettier" },
        
        -- =============================================================================
        -- DATA FORMATS
        -- =============================================================================
        json = { "prettier", "jsonlint" },
        jsonc = { "prettier" },
        yaml = { "prettier", "yamllint" },
        yml = { "prettier", "yamllint" },
        toml = { "prettier" },
        xml = { "prettier" },
        
        -- =============================================================================
        -- DOCUMENTATION
        -- =============================================================================
        markdown = { "prettier" },
        markdown_inline = { "prettier" },
        mdx = { "prettier" },
        
        -- =============================================================================
        -- QUERY LANGUAGES
        -- =============================================================================
        graphql = { "prettier" },
        gql = { "prettier" },
        sql = { "sqlfluff" },
        
        -- =============================================================================
        -- TEMPLATE LANGUAGES
        -- =============================================================================
        liquid = { "prettier" },
        handlebars = { "prettier" },
        hbs = { "prettier" },
        
        -- =============================================================================
        -- BACKEND LANGUAGES
        -- =============================================================================
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "gofumpt", "goimports" },
        rust = { "rustfmt" },
        java = { "google_java_format" },
        kotlin = { "ktlint" },
        scala = { "scalafmt" },
        
        -- =============================================================================
        -- SHELL & SCRIPTING
        -- =============================================================================
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        fish = { "fish_indent" },
        
        -- =============================================================================
        -- CONFIGURATION FILES
        -- =============================================================================
        dockerfile = { "hadolint" },
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
        nix = { "nixfmt" },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>mp", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}