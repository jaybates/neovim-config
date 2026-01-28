-- =============================================================================
-- Doom Emacs Style Dashboard Configuration
-- =============================================================================
-- A beautiful startup screen inspired by Doom Emacs
-- Features recent files, projects, and quick actions

return {
    "goolord/alpha-nvim",
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        -- =============================================================================
        -- PLUGIN IMPORTS
        -- =============================================================================
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.dashboard")
        local plenary = require("plenary")
        local icons = require("nvim-web-devicons")

        -- =============================================================================
        -- UTILITY FUNCTIONS
        -- =============================================================================
        local function get_os()
            local os_name = vim.loop.os_uname().sysname
            if os_name == "Darwin" then
                return "macOS"
            elseif os_name == "Linux" then
                return "Linux"
            elseif os_name == "Windows_NT" then
                return "Windows"
            else
                return os_name
            end
        end

        local function get_uptime()
            local uptime = vim.loop.uptime()
            local days = math.floor(uptime / 86400)
            local hours = math.floor((uptime % 86400) / 3600)
            local minutes = math.floor((uptime % 3600) / 60)
            
            if days > 0 then
                return string.format("%dd %dh %dm", days, hours, minutes)
            elseif hours > 0 then
                return string.format("%dh %dm", hours, minutes)
            else
                return string.format("%dm", minutes)
            end
        end

        local function get_plugin_count()
            local lazy_ok, lazy = pcall(require, "lazy")
            if lazy_ok then
                local stats = lazy.stats()
                return stats.count
            end
            return "Unknown"
        end

        local function get_lsp_count()
            local clients = vim.lsp.get_active_clients()
            return #clients
        end

        -- =============================================================================
        -- DOOM EMACS STYLE HEADER
        -- =============================================================================
        local function get_header()
            local headers = {
                {
                    "                                                                              ",
                    "    ██████╗  ██████╗  ██████╗ ███╗   ███╗    ███████╗███╗   ███╗ █████╗  ██████╗ ",
                    "    ██╔══██╗██╔═══██╗██╔═══██╗████╗ ████║    ██╔════╝████╗ ████║██╔══██╗██╔════╝ ",
                    "    ██║  ██║██║   ██║██║   ██║██╔████╔██║    █████╗  ██╔████╔██║███████║██║  ███╗",
                    "    ██║  ██║██║   ██║██║   ██║██║╚██╔╝██║    ██╔══╝  ██║╚██╔╝██║██╔══██║██║   ██║",
                    "    ██████╔╝╚██████╔╝╚██████╔╝██║ ╚═╝ ██║    ███████╗██║ ╚═╝ ██║██║  ██║╚██████╔╝",
                    "    ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝     ╚═╝    ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ",
                    "                                                                              ",
                },
                {
                    "                                                                              ",
                    "    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗    ███████╗███╗   ███╗ █████╗  ██████╗ ",
                    "    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║    ██╔════╝████╗ ████║██╔══██╗██╔════╝ ",
                    "    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║    █████╗  ██╔████╔██║███████║██║  ███╗",
                    "    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║    ██╔══╝  ██║╚██╔╝██║██╔══██║██║   ██║",
                    "    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║    ███████╗██║ ╚═╝ ██║██║  ██║╚██████╔╝",
                    "    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝    ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ",
                    "                                                                              ",
                },
                {
                    "                                                                              ",
                    "    ╔══════════════════════════════════════════════════════════════════════════╗",
                    "    ║                                                                          ║",
                    "    ║    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗                    ║",
                    "    ║    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║                    ║",
                    "    ║    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║                    ║",
                    "    ║    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║                    ║",
                    "    ║    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║                    ║",
                    "    ║    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝                    ║",
                    "    ║                                                                          ║",
                    "    ║    ███████╗███╗   ███╗ █████╗  ██████╗ ███████╗                          ║",
                    "    ║    ██╔════╝████╗ ████║██╔══██╗██╔════╝ ██╔════╝                          ║",
                    "    ║    █████╗  ██╔████╔██║███████║██║  ███╗█████╗                            ║",
                    "    ║    ██╔══╝  ██║╚██╔╝██║██╔══██║██║   ██║██╔══╝                            ║",
                    "    ║    ███████╗██║ ╚═╝ ██║██║  ██║╚██████╔╝███████╗                          ║",
                    "    ║    ╚══════╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝                          ║",
                    "    ║                                                                          ║",
                    "    ╚══════════════════════════════════════════════════════════════════════════╝",
                    "                                                                              ",
                }
            }
            
            -- Randomly select a header
            local random_index = math.random(1, #headers)
            return headers[random_index]
        end

        -- =============================================================================
        -- SYSTEM INFORMATION
        -- =============================================================================
        local function get_system_info()
            local info = {
                "┌─ System Information ──────────────────────────────────────────────┐",
                string.format("│ OS: %-20s │ Uptime: %-15s │", get_os(), get_uptime()),
                string.format("│ Plugins: %-15s │ LSP Servers: %-10s │", get_plugin_count(), get_lsp_count()),
                "└─────────────────────────────────────────────────────────────────┘",
            }
            return info
        end

        -- =============================================================================
        -- RECENT FILES
        -- =============================================================================
        local function get_recent_files()
            local recent_files = {}
            local oldfiles = vim.v.oldfiles
            
            table.insert(recent_files, "┌─ Recent Files ─────────────────────────────────────────────────────┐")
            
            for i = 1, math.min(5, #oldfiles) do
                local file = oldfiles[i]
                local filename = vim.fn.fnamemodify(file, ":t")
                local path = vim.fn.fnamemodify(file, ":~")
                local icon = icons.get_icon(filename) or "📄"
                
                table.insert(recent_files, string.format("│ %s %-20s │ %-30s │", icon, filename, path))
            end
            
            table.insert(recent_files, "└─────────────────────────────────────────────────────────────────┘")
            return recent_files
        end

        -- =============================================================================
        -- QUICK ACTIONS
        -- =============================================================================
        local function get_quick_actions()
            return {
                "┌─ Quick Actions ──────────────────────────────────────────────────┐",
                "│ [e]  New File          [f]  Find Files        [g]  Live Grep    │",
                "│ [r]  Recent Files      [p]  Projects          [t]  File Tree    │",
                "│ [s]  Sessions          [c]  Config            [q]  Quit         │",
                "└─────────────────────────────────────────────────────────────────┘",
            }
        end

        -- =============================================================================
        -- DASHBOARD CONFIGURATION
        -- =============================================================================
        dashboard.section.header.val = get_header()
        
        -- System information
        dashboard.section.footer.val = get_system_info()
        
        -- Recent files section
        dashboard.section.recent_files.val = get_recent_files()
        
        -- Quick actions
        dashboard.section.quick_actions.val = get_quick_actions()

        -- =============================================================================
        -- BUTTONS CONFIGURATION
        -- =============================================================================
        dashboard.section.buttons.val = {
            dashboard.button("e", "📄 New File", "<cmd>ene<CR>"),
            dashboard.button("f", "🔍 Find Files", "<cmd>Telescope find_files<CR>"),
            dashboard.button("g", "🔎 Live Grep", "<cmd>Telescope live_grep<CR>"),
            dashboard.button("r", "📋 Recent Files", "<cmd>Telescope oldfiles<CR>"),
            dashboard.button("p", "📁 Projects", "<cmd>Telescope projects<CR>"),
            dashboard.button("t", "🌳 File Tree", "<cmd>NvimTreeToggle<CR>"),
            dashboard.button("s", "💾 Sessions", "<cmd>SessionManager load_session<CR>"),
            dashboard.button("c", "⚙️  Config", "<cmd>e ~/.config/nvim/init.lua<CR>"),
            dashboard.button("q", "🚪 Quit", "<cmd>qa<CR>"),
        }

        -- =============================================================================
        -- LAYOUT CONFIGURATION
        -- =============================================================================
        dashboard.opts.layout = {
            { type = "padding", val = 1 },
            dashboard.section.header,
            { type = "padding", val = 2 },
            dashboard.section.quick_actions,
            { type = "padding", val = 1 },
            dashboard.section.recent_files,
            { type = "padding", val = 1 },
            dashboard.section.buttons,
            { type = "padding", val = 1 },
            dashboard.section.footer,
        }

        -- =============================================================================
        -- STYLING
        -- =============================================================================
        dashboard.opts.opts = {
            margin = 5,
            redraw_on_resize = true,
            setup = function()
                vim.api.nvim_create_autocmd("DirChanged", {
                    pattern = "*",
                    group = "alpha_temp",
                    callback = function()
                        require("alpha").redraw()
                    end,
                })
            end,
        }

        -- =============================================================================
        -- APPLY CONFIGURATION
        -- =============================================================================
        alpha.setup(dashboard.opts)

        -- =============================================================================
        -- AUTOCMDS
        -- =============================================================================
        vim.api.nvim_create_augroup("alpha_temp", { clear = true })
        vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
        vim.cmd([[autocmd FileType alpha setlocal nonumber]])
        vim.cmd([[autocmd FileType alpha setlocal norelativenumber]])
        vim.cmd([[autocmd FileType alpha setlocal signcolumn=no]])
    end
}
