-- =============================================================================
-- Debugging Configuration
-- =============================================================================
-- Debug Adapter Protocol (DAP) integration for debugging
-- Supports multiple languages and debuggers

return {
  -- =============================================================================
  -- DAP CORE
  -- =============================================================================
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-telescope/telescope-dap.nvim",
      "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local dap_virtual_text = require("nvim-dap-virtual-text")

      -- =============================================================================
      -- DAP UI SETUP
      -- =============================================================================
      dapui.setup({
        icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
        mappings = {
          expand = { "<CR>", "<2-LeftMouse>" },
          open = "o",
          remove = "d",
          edit = "e",
          repl = "r",
          toggle = "t",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.25 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.25 },
              { id = "watches", size = 0.25 },
            },
            position = "left",
            size = 40,
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            position = "bottom",
            size = 10,
          },
        },
        floating = {
          max_height = nil,
          max_width = nil,
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil,
          max_value_lines = 100,
        },
      })

      -- =============================================================================
      -- VIRTUAL TEXT SETUP
      -- =============================================================================
      dap_virtual_text.setup({
        commented = true,
        enabled_commands = true,
        highlight_changed_variables = true,
        highlight_new_as_changed = false,
        show_stop_reason = true,
        only_first_definition = true,
        all_references = false,
        clear_on_continue = false,
        display_callback = function(variable, _buf, _stackframe, _node)
          return variable.name .. " = " .. variable.value
        end,
        virt_text_pos = "eol",
        all_frames = false,
        virt_lines = false,
        virt_text_win_col = nil,
      })

      -- =============================================================================
      -- DEBUGGER CONFIGURATIONS
      -- =============================================================================
      
      -- Node.js debugging
      dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
      }

      dap.configurations.javascript = {
        {
          name = "Launch",
          type = "node2",
          request = "launch",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
        },
        {
          name = "Attach to process",
          type = "node2",
          request = "attach",
          processId = require("dap.utils").pick_process,
        },
      }

      dap.configurations.typescript = dap.configurations.javascript

      -- Python debugging
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          name = "Launch",
          type = "python",
          request = "launch",
          program = "${file}",
          python = function()
            return "/usr/bin/python3"
          end,
          cwd = "${workspaceFolder}",
          args = {},
          justMyCode = true,
        },
        {
          name = "Attach",
          type = "python",
          request = "attach",
          connect = {
            port = 5678,
            host = "127.0.0.1",
          },
          pathMappings = {
            {
              localRoot = "${workspaceFolder}",
              remoteRoot = ".",
            },
          },
        },
      }

      -- =============================================================================
      -- KEY MAPPINGS
      -- =============================================================================
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
      vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })
      vim.keymap.set("n", "<leader>lp", function()
        dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      end, { desc = "Debug: Log Point" })
      vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Debug: Open REPL" })
      vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run Last" })
      vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
      vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })

      -- =============================================================================
      -- AUTO-OPEN DAP UI
      -- =============================================================================
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- =============================================================================
  -- DAP UI
  -- =============================================================================
  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio", -- Required by nvim-dap-ui
    },
  },

  -- =============================================================================
  -- DAP VIRTUAL TEXT
  -- =============================================================================
  {
    "theHamsta/nvim-dap-virtual-text",
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
  },

  -- =============================================================================
  -- TELESCOPE DAP
  -- =============================================================================
  {
    "nvim-telescope/telescope-dap.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap" },
    config = function()
      require("telescope").load_extension("dap")
    end,
  },
}
