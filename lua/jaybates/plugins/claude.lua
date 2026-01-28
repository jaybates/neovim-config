-- =============================================================================
-- Claude Code Integration Configuration
-- =============================================================================
-- Integration with Claude AI for code assistance, generation, and analysis
-- Requires Claude API key and supports various AI-powered features

return {
    "jbyuki/nabla.nvim",
    event = "VeryLazy",
    config = function()
        -- =============================================================================
        -- NABLA SETUP (LaTeX Math Rendering)
        -- =============================================================================
        -- nabla.nvim doesn't require setup, it works out of the box
        -- You can use :nabla-toggle to toggle math preview
        -- Optional: Set up key mappings for convenience
        vim.keymap.set("n", "<leader>nm", ":nabla-toggle<CR>", { desc = "Toggle Math Preview (∇)" })
        
        -- =============================================================================
        -- CLAUDE AI INTEGRATION VIA CUSTOM PLUGIN
        -- =============================================================================
        -- This is a custom implementation for Claude integration
        -- You'll need to install additional dependencies

        -- Dependencies for Claude integration
        local claude_dependencies = {
            "nvim-lua/plenary.nvim", -- Required for HTTP requests
            "rcarriga/nvim-notify",  -- For notifications
        }

        -- Check if dependencies are available
        local function has_claude_dependencies()
            local plenary_ok = pcall(require, "plenary")
            local notify_ok = pcall(require, "notify")
            return plenary_ok and notify_ok
        end

        -- Create a custom Claude integration
        local function setup_claude_integration()
            -- Check if dependencies are available
            if not has_claude_dependencies() then
                vim.notify("Claude integration requires plenary.nvim and nvim-notify", "warn")
                return
            end
            
            local notify = require("notify")
            local plenary = require("plenary")
            
            -- Claude API configuration
            local claude_config = {
                api_key = os.getenv("CLAUDE_API_KEY"),
                base_url = "https://api.anthropic.com/v1/messages",
                model = "claude-3-5-sonnet-20241022",
            }
            
            -- Check if API key is available
            if not claude_config.api_key then
                notify("Claude API key not found. Set CLAUDE_API_KEY environment variable.", "warn")
                return
            end
            
            -- Claude request function
            local function claude_request(prompt, callback)
                local http = require("plenary.curl")
                
                local request_body = {
                    model = claude_config.model,
                    max_tokens = 4000,
                    messages = {
                        {
                            role = "user",
                            content = prompt
                        }
                    }
                }
                
                http.request({
                    url = claude_config.base_url,
                    method = "POST",
                    headers = {
                        ["Content-Type"] = "application/json",
                        ["x-api-key"] = claude_config.api_key,
                        ["anthropic-version"] = "2023-06-01"
                    },
                    body = vim.json.encode(request_body),
                    callback = function(response)
                        if response.status == 200 then
                            local data = vim.json.decode(response.body)
                            if data.content and data.content[1] then
                                callback(data.content[1].text)
                            else
                                callback("Error: No response from Claude")
                            end
                        else
                            callback("Error: " .. tostring(response.status))
                        end
                    end
                })
            end
            
            -- Code review function
            local function claude_code_review()
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                local code = table.concat(lines, "\n")
                local filetype = vim.bo.filetype
                
                local prompt = string.format([[
Please review this %s code and provide:
1. Code quality assessment
2. Potential bugs or issues
3. Performance improvements
4. Best practices suggestions
5. Security considerations

Code:
```%s
%s
```
]], filetype, filetype, code)
                
                claude_request(prompt, function(response)
                    -- Create a new buffer for the review
                    local buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                    vim.api.nvim_buf_set_option(buf, "modifiable", false)
                    
                    -- Open in a split
                    vim.api.nvim_open_win(buf, true, {
                        relative = "editor",
                        width = 80,
                        height = 20,
                        col = 10,
                        row = 10,
                        border = "rounded",
                        title = "Claude Code Review",
                        title_pos = "center",
                    })
                end)
            end
            
            -- Code generation function
            local function claude_generate_code()
                local input = vim.fn.input("Describe what you want to generate: ")
                if input == "" then return end
                
                local filetype = vim.bo.filetype
                local prompt = string.format([[
Generate %s code for: %s

Please provide:
1. Complete, working code
2. Comments explaining the logic
3. Error handling where appropriate
4. Best practices for %s

Format the response as markdown with code blocks.
]], filetype, input, filetype)
                
                claude_request(prompt, function(response)
                    -- Create a new buffer for the generated code
                    local buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                    
                    -- Open in a split
                    vim.api.nvim_open_win(buf, true, {
                        relative = "editor",
                        width = 100,
                        height = 25,
                        col = 5,
                        row = 5,
                        border = "rounded",
                        title = "Claude Generated Code",
                        title_pos = "center",
                    })
                end)
            end
            
            -- Code explanation function
            local function claude_explain_code()
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                local code = table.concat(lines, "\n")
                local filetype = vim.bo.filetype
                
                local prompt = string.format([[
Please explain this %s code in detail:

1. What does this code do?
2. How does it work?
3. What are the key concepts used?
4. Are there any potential issues?
5. How could it be improved?

Code:
```%s
%s
```
]], filetype, filetype, code)
                
                claude_request(prompt, function(response)
                    -- Create a new buffer for the explanation
                    local buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                    vim.api.nvim_buf_set_option(buf, "modifiable", false)
                    
                    -- Open in a split
                    vim.api.nvim_open_win(buf, true, {
                        relative = "editor",
                        width = 80,
                        height = 20,
                        col = 10,
                        row = 10,
                        border = "rounded",
                        title = "Claude Code Explanation",
                        title_pos = "center",
                    })
                end)
            end
            
            -- Refactor code function
            local function claude_refactor_code()
                local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
                local code = table.concat(lines, "\n")
                local filetype = vim.bo.filetype
                
                local prompt = string.format([[
Please refactor this %s code to make it:
1. More readable and maintainable
2. More efficient
3. Follow best practices
4. Have better error handling
5. Be more modular

Provide the refactored code with explanations of changes.

Original code:
```%s
%s
```
]], filetype, filetype, code)
                
                claude_request(prompt, function(response)
                    -- Create a new buffer for the refactored code
                    local buf = vim.api.nvim_create_buf(false, true)
                    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(response, "\n"))
                    vim.api.nvim_buf_set_option(buf, "filetype", "markdown")
                    
                    -- Open in a split
                    vim.api.nvim_open_win(buf, true, {
                        relative = "editor",
                        width = 100,
                        height = 25,
                        col = 5,
                        row = 5,
                        border = "rounded",
                        title = "Claude Refactored Code",
                        title_pos = "center",
                    })
                end)
            end
            
            -- Set up key mappings
            vim.keymap.set("n", "<leader>cc", claude_code_review, { desc = "Claude: Code Review" })
            vim.keymap.set("n", "<leader>cg", claude_generate_code, { desc = "Claude: Generate Code" })
            vim.keymap.set("n", "<leader>ce", claude_explain_code, { desc = "Claude: Explain Code" })
            vim.keymap.set("n", "<leader>cr", claude_refactor_code, { desc = "Claude: Refactor Code" })
            
            -- Set up commands
            vim.api.nvim_create_user_command("ClaudeReview", claude_code_review, { desc = "Review code with Claude" })
            vim.api.nvim_create_user_command("ClaudeGenerate", claude_generate_code, { desc = "Generate code with Claude" })
            vim.api.nvim_create_user_command("ClaudeExplain", claude_explain_code, { desc = "Explain code with Claude" })
            vim.api.nvim_create_user_command("ClaudeRefactor", claude_refactor_code, { desc = "Refactor code with Claude" })
            
            notify("Claude integration loaded successfully!", "info")
        end

        -- Initialize Claude integration with conditions
        local function init_claude_integration()
            -- Check Neovim plugin dependencies
            if not has_claude_dependencies() then
                vim.api.nvim_create_user_command("ClaudeInit", function()
                    if has_claude_dependencies() then
                        setup_claude_integration()
                    else
                        vim.notify("Please install required Neovim plugins: plenary.nvim and nvim-notify", "error")
                    end
                end, { desc = "Initialize Claude integration" })
                return
            end
            
            -- Check API key
            if not os.getenv("CLAUDE_API_KEY") then
                vim.api.nvim_create_user_command("ClaudeInit", function()
                    if os.getenv("CLAUDE_API_KEY") then
                        setup_claude_integration()
                    else
                        vim.notify("Please set CLAUDE_API_KEY environment variable", "error")
                    end
                end, { desc = "Initialize Claude integration" })
                return
            end
            
            -- All dependencies are available, initialize
            setup_claude_integration()
        end

        -- Initialize Claude integration when the plugin loads (skip when opening with no file so dashboard stays)
        vim.api.nvim_create_autocmd("VimEnter", {
            once = true,
            callback = function()
                if vim.fn.argc() == 0 then return end
                init_claude_integration()
            end,
        })
    end,
}