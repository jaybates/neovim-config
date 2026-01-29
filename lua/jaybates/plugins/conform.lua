return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    -- Resolve at runtime so Mason-installed tools work after :MasonInstall
    local mason = vim.fn.stdpath("data") .. "/mason/bin"
    local function get_eslint_d_cmd()
        local p = mason .. "/eslint_d"
        return (vim.fn.executable(p) == 1) and p or "eslint_d"
    end
    local function get_prettier_cmd()
        local p = mason .. "/prettier"
        return (vim.fn.executable(p) == 1) and p or "prettier"
    end
    local function get_stylelint_cmd()
        local p = mason .. "/stylelint"
        return (vim.fn.executable(p) == 1) and p or "stylelint"
    end

    conform.setup({
      formatters = {
        -- Resolved at config load; restart nvim after :MasonInstall for new tools
        eslint_d = { command = get_eslint_d_cmd() },
        prettier = { command = get_prettier_cmd() },
        stylelint = { command = get_stylelint_cmd() },
      },
      formatters_by_ft = {
        -- React, JS, Node
        javascript = { "prettier", "eslint_d" },
        typescript = { "prettier", "eslint_d" },
        javascriptreact = { "prettier", "eslint_d" },
        typescriptreact = { "prettier", "eslint_d" },
        jsx = { "prettier", "eslint_d" },
        tsx = { "prettier", "eslint_d" },
        -- Styling
        css = { "prettier", "stylelint" },
        scss = { "prettier", "stylelint" },
        sass = { "prettier", "stylelint" },
        less = { "prettier", "stylelint" },
        -- Markup (htmlhint is linter only; use nvim-lint for HTML linting)
        html = { "prettier" },
        php = { "prettier" },
        -- Data: JSON, YAML, XML, GraphQL, SQL
        json = { "prettier", "jsonlint" },
        jsonc = { "prettier" },
        yaml = { "prettier", "yamllint" },
        yml = { "prettier", "yamllint" },
        toml = { "prettier" },
        xml = { "prettier" },
        graphql = { "prettier" },
        gql = { "prettier" },
        sql = { "sqlfluff" },
        -- Backend
        lua = { "stylua" },
        python = { "isort", "black" },
        go = { "gofumpt", "goimports" },
        -- Docs
        markdown = { "prettier" },
        markdown_inline = { "prettier" },
        mdx = { "prettier" },
        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },
        zsh = { "shfmt" },
        -- Docker, Terraform (hadolint is linter only; terraform_fmt needs Terraform CLI)
        dockerfile = {},
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
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