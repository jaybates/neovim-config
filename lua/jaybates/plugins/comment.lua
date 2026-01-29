return {
    "numToStr/Comment.nvim",
    priority = 100, -- After treesitter (150); needs ts_context_commentstring
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {"JoosepAlviste/nvim-ts-context-commentstring"},
    config = function()
        -- Skip deprecated nvim-treesitter module; use standalone setup (see issue #82)
        vim.g.skip_ts_context_commentstring_module = true
        require("ts_context_commentstring").setup({})

        local comment = require("Comment")
        local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")

        comment.setup({
            -- for commenting tsx, jsx, html (and other TS-context filetypes)
            pre_hook = ts_context_commentstring.create_pre_hook()
        })
    end
}
