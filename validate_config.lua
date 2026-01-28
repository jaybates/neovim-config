-- =============================================================================
-- Neovim Configuration Validation Script
-- =============================================================================
-- This script validates the Neovim configuration for common issues
-- Run with: nvim --headless -c "luafile validate_config.lua" -c "quit"

local function validate_config()
  local issues = {}
  local warnings = {}
  
  print("🔍 Validating Neovim configuration...")
  
  -- Check if lazy.nvim is installed
  local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazy_path) then
    table.insert(issues, "❌ lazy.nvim is not installed")
  else
    print("✅ lazy.nvim is installed")
  end
  
  -- Check if required directories exist
  local config_dir = vim.fn.stdpath("config")
  local required_dirs = {
    "lua/jaybates",
    "lua/jaybates/core",
    "lua/jaybates/plugins",
    "lua/jaybates/plugins/lsp",
  }
  
  for _, dir in ipairs(required_dirs) do
    local full_path = config_dir .. "/" .. dir
    if not vim.loop.fs_stat(full_path) then
      table.insert(issues, "❌ Missing directory: " .. dir)
    else
      print("✅ Directory exists: " .. dir)
    end
  end
  
  -- Check if required files exist
  local required_files = {
    "init.lua",
    "lua/jaybates/init.lua",
    "lua/jaybates/lazy.lua",
    "lua/jaybates/core/init.lua",
    "lua/jaybates/core/options.lua",
    "lua/jaybates/core/keyremaps.lua",
    "lua/jaybates/core/keymaps.lua",
    "lua/jaybates/plugins/init.lua",
  }
  
  for _, file in ipairs(required_files) do
    local full_path = config_dir .. "/" .. file
    if not vim.loop.fs_stat(full_path) then
      table.insert(issues, "❌ Missing file: " .. file)
    else
      print("✅ File exists: " .. file)
    end
  end
  
  -- Check for common configuration issues
  local config_file = config_dir .. "/lua/jaybates/core/options.lua"
  if vim.loop.fs_stat(config_file) then
    local content = vim.fn.readfile(config_file)
    local content_str = table.concat(content, "\n")
    
    -- Check for duplicate options
    if vim.fn.count(content_str, "vim.opt.splitbelow") > 1 then
      table.insert(warnings, "⚠️  Duplicate splitbelow option in options.lua")
    end
    
    if vim.fn.count(content_str, "vim.opt.splitright") > 1 then
      table.insert(warnings, "⚠️  Duplicate splitright option in options.lua")
    end
  end
  
  -- Check if external dependencies are available
  local dependencies = {
    { cmd = "node", name = "Node.js" },
    { cmd = "fd", name = "fd" },
    { cmd = "rg", name = "ripgrep" },
    { cmd = "make", name = "make" },
  }
  
  for _, dep in ipairs(dependencies) do
    if vim.fn.executable(dep.cmd) == 0 then
      table.insert(warnings, "⚠️  " .. dep.name .. " not found (recommended for optimal performance)")
    else
      print("✅ " .. dep.name .. " is available")
    end
  end
  
  -- Print results
  print("\n" .. string.rep("=", 50))
  print("📊 VALIDATION RESULTS")
  print(string.rep("=", 50))
  
  if #issues == 0 and #warnings == 0 then
    print("🎉 Configuration is valid! No issues found.")
  else
    if #issues > 0 then
      print("\n❌ ISSUES FOUND:")
      for _, issue in ipairs(issues) do
        print("  " .. issue)
      end
    end
    
    if #warnings > 0 then
      print("\n⚠️  WARNINGS:")
      for _, warning in ipairs(warnings) do
        print("  " .. warning)
      end
    end
  end
  
  print("\n💡 TIPS:")
  print("  • Run :Lazy sync to install/update plugins")
  print("  • Run :Mason to install LSP servers")
  print("  • Run :TSUpdate to update treesitter parsers")
  print("  • Check :checkhealth for detailed diagnostics")
  
  return #issues == 0
end

-- Run validation
local success = validate_config()

if success then
  print("\n✅ Configuration validation completed successfully!")
else
  print("\n❌ Configuration validation found issues that need attention.")
end
