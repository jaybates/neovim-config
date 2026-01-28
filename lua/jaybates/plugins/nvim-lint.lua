-- =============================================================================
-- nvim-lint Linting Configuration
-- =============================================================================
-- Provides asynchronous linting for various file types
-- Supports ESLint, Prettier, and other linters

return {
    "mfussenegger/nvim-lint",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        -- =============================================================================
        -- PLUGIN IMPORTS
        -- =============================================================================
        local lint = require("lint")

        -- =============================================================================
        -- LINTER CONFIGURATION BY FILE TYPE
        -- =============================================================================
        lint.linters_by_ft = {
            -- =============================================================================
            -- WEB DEVELOPMENT
            -- =============================================================================
            javascript = {"eslint_d", "prettier"},
            typescript = {"eslint_d", "prettier"},
            javascriptreact = {"eslint_d", "prettier"},
            typescriptreact = {"eslint_d", "prettier"},
            jsx = {"eslint_d", "prettier"},
            tsx = {"eslint_d", "prettier"},
            
            -- =============================================================================
            -- STYLING
            -- =============================================================================
            css = {"stylelint"},
            scss = {"stylelint"},
            sass = {"stylelint"},
            less = {"stylelint"},
            
            -- =============================================================================
            -- MARKUP
            -- =============================================================================
            html = {"htmlhint"},
            vue = {"eslint_d", "prettier"},
            svelte = {"eslint_d", "prettier"},
            
            -- =============================================================================
            -- CONFIGURATION FILES
            -- =============================================================================
            json = {"jsonlint"},
            yaml = {"yamllint"},
            yml = {"yamllint"},
            
            -- =============================================================================
            -- BACKEND LANGUAGES
            -- =============================================================================
            python = {"flake8", "pylint"},
            lua = {"luacheck"},
            go = {"golangci_lint"},
            rust = {"cargo_check"},
            
            -- =============================================================================
            -- SHELL & SCRIPTING
            -- =============================================================================
            sh = {"shellcheck"},
            bash = {"shellcheck"},
            zsh = {"shellcheck"},
        }

        -- =============================================================================
        -- CUSTOM LINTER CONFIGURATIONS
        -- =============================================================================
        lint.linters.eslint_d = {
            cmd = "eslint_d",
            stdin = true,
            args = {
                "--stdin",
                "--stdin-filename",
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
                "--format",
                "json",
            },
            ignore_exitcode = true,
            env = nil,
            stream = nil,
            parser = function(output, bufnr)
                local decoded = vim.json.decode(output)
                local diagnostics = {}
                
                if decoded and decoded.messages then
                    for _, message in ipairs(decoded.messages) do
                        table.insert(diagnostics, {
                            lnum = (message.line or 1) - 1,
                            col = (message.column or 1) - 1,
                            end_lnum = (message.endLine or message.line or 1) - 1,
                            end_col = (message.endColumn or message.column or 1) - 1,
                            severity = message.severity == 2 and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
                            source = "eslint",
                            message = message.message,
                            code = message.ruleId,
                        })
                    end
                end
                
                return diagnostics
            end,
        }

        -- =============================================================================
        -- PRETTIER LINTER CONFIGURATION
        -- =============================================================================
        lint.linters.prettier = {
            cmd = "prettier",
            stdin = true,
            args = {
                "--check",
                "--stdin-filepath",
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
            },
            ignore_exitcode = true,
            parser = function(output, bufnr)
                local diagnostics = {}
                local lines = vim.split(output, "\n")
                
                for _, line in ipairs(lines) do
                    if line:match("Code style issues found") then
                        table.insert(diagnostics, {
                            lnum = 0,
                            col = 0,
                            severity = vim.diagnostic.severity.WARN,
                            source = "prettier",
                            message = "Code style issues found. Run :Format to fix.",
                        })
                        break
                    end
                end
                
                return diagnostics
            end,
        }

        -- =============================================================================
        -- STYLELINT CONFIGURATION
        -- =============================================================================
        lint.linters.stylelint = {
            cmd = "stylelint",
            stdin = true,
            args = {
                "--stdin-filename",
                function()
                    return vim.api.nvim_buf_get_name(0)
                end,
                "--formatter",
                "json",
            },
            ignore_exitcode = true,
            parser = function(output, bufnr)
                local decoded = vim.json.decode(output)
                local diagnostics = {}
                
                if decoded and decoded[1] and decoded[1].warnings then
                    for _, warning in ipairs(decoded[1].warnings) do
                        table.insert(diagnostics, {
                            lnum = warning.line - 1,
                            col = warning.column - 1,
                            severity = vim.diagnostic.severity.WARN,
                            source = "stylelint",
                            message = warning.text,
                            code = warning.rule,
                        })
                    end
                end
                
                return diagnostics
            end,
        }

        -- =============================================================================
        -- AUTO-LINTING SETUP
        -- =============================================================================
        local lint_augroup = vim.api.nvim_create_augroup("lint", {
            clear = true
        })

        vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave"}, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end
        })

        -- =============================================================================
        -- KEY MAPPINGS
        -- =============================================================================
        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, {
            desc = "Trigger linting for current file"
        })

        vim.keymap.set("n", "<leader>L", function()
            lint.try_lint()
            vim.notify("Linting completed", vim.log.levels.INFO)
        end, {
            desc = "Trigger linting and show notification"
        })
    end
}
