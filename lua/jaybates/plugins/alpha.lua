-- =============================================================================
-- Alpha-nvim: default startup screen
-- =============================================================================
-- Uses the built-in dashboard theme with custom NEOVIM header.
-- Shows when you open Neovim with no file.

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
        -- Only show dashboard when opening Neovim with no file/dir
        if vim.fn.argc() > 0 then return end
        local dashboard = require("alpha.themes.dashboard")

        dashboard.section.header.val = {
            "",
            "    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
            "    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
            "    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
            "    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
            "    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
            "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
            "",
        }

        require("alpha").setup(dashboard.opts)
    end,
}
