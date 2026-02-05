-- =============================================================================
-- Symbols Outline Configuration
-- =============================================================================
-- Tree-like view of LSP document symbols (functions, classes, types, etc.)
-- Toggle with <leader>so; in the outline: Enter to go to location, o to focus.

return {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>so", "<cmd>SymbolsOutline<cr>", desc = "Symbols outline" } },
    config = function()
        require("symbols-outline").setup({
            position = "right",
            relative_width = true,
            width = 25,
            auto_close = false,
            auto_preview = true,
            border = "rounded",
            show_guides = true,
            show_symbol_details = true,
            highlight_hovered_item = true,
            keymaps = {
                close = { "<Esc>", "q" },
                goto_location = "<Cr>",
                focus_location = "o",
                hover_symbol = "<C-space>",
                toggle_preview = "K",
                rename_symbol = "r",
                code_actions = "a",
                fold = "h",
                unfold = "l",
                fold_all = "W",
                unfold_all = "E",
                fold_reset = "R",
            },
        })
    end,
}
