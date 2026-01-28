-- =============================================================================
-- Dependency Installer
-- =============================================================================
-- Automatically installs external dependencies required by plugins
-- Only runs if dependencies are not already installed

local M = {}

-- External dependencies required by various plugins
local external_dependencies = {
    -- System utilities
    curl = "curl",           -- For HTTP requests (Claude integration)
    jq = "jq",               -- For JSON parsing (optional but helpful)
    fd = "fd",               -- For fast file finding (Telescope)
    ripgrep = "rg",          -- For fast text searching (Telescope)
    fzf = "fzf",             -- For fuzzy finding (Telescope fzf extension)
    
    -- Terminal and CLI tools
    lazygit = "lazygit",     -- For Git operations in terminal
    htop = "htop",           -- For system monitoring
    tree = "tree",           -- For directory tree visualization
    bat = "bat",             -- For syntax-highlighted file viewing
    eza = "eza",             -- For enhanced ls command (replacement for exa)
    
    -- Language servers and tools (will be installed via Mason, but system deps needed)
    node = "node",           -- For JavaScript/TypeScript LSP
    python3 = "python3",     -- For Python LSP
    go = "go",               -- For Go LSP
    rustc = "rustc",         -- For Rust LSP
}

-- Package manager commands for different systems
local package_managers = {
    mac = {
        command = "brew",
        install = "brew install",
        check = "brew list",
    },
    ubuntu = {
        command = "apt",
        install = "sudo apt update && sudo apt install -y",
        check = "dpkg -l",
    },
    debian = {
        command = "apt",
        install = "sudo apt update && sudo apt install -y",
        check = "dpkg -l",
    },
    centos = {
        command = "yum",
        install = "sudo yum install -y",
        check = "rpm -qa",
    },
    rhel = {
        command = "yum",
        install = "sudo yum install -y",
        check = "rpm -qa",
    },
    arch = {
        command = "pacman",
        install = "sudo pacman -S --noconfirm",
        check = "pacman -Q",
    },
}

-- Detect the current operating system
local function detect_os()
    if vim.fn.has("mac") == 1 then
        return "mac"
    elseif vim.fn.has("unix") == 1 then
        -- Try to detect Linux distribution
        local handle = io.popen("cat /etc/os-release 2>/dev/null | grep ^ID= | cut -d= -f2")
        local os_id = handle:read("*l")
        handle:close()
        
        if os_id then
            os_id = os_id:gsub('"', '') -- Remove quotes
            if package_managers[os_id] then
                return os_id
            end
        end
        
        -- Fallback to generic Linux
        return "ubuntu" -- Default to Ubuntu commands
    end
    return nil
end

-- Check if a command exists
local function command_exists(command)
    return vim.fn.executable(command) == 1
end

-- Check if external dependencies are installed
function M.check_dependencies()
    local missing = {}
    for name, command in pairs(external_dependencies) do
        if not command_exists(command) then
            table.insert(missing, name)
        end
    end
    return #missing == 0, missing
end

-- Install missing dependencies
function M.install_dependencies(missing_deps)
    local os = detect_os()
    if not os or not package_managers[os] then
        vim.notify("Unsupported operating system for automatic dependency installation", "warn")
        return false
    end
    
    local pm = package_managers[os]
    local notify = require("notify")
    
    -- Check if package manager is available
    if not command_exists(pm.command) then
        local instructions = string.format(
            "Package manager '%s' not found. Please install it first.\n" ..
            "On macOS: Install Homebrew from https://brew.sh\n" ..
            "On Ubuntu/Debian: sudo apt update && sudo apt install %s\n" ..
            "On CentOS/RHEL: sudo yum install %s\n" ..
            "On Arch: sudo pacman -S %s",
            pm.command, pm.command, pm.command, pm.command
        )
        notify(instructions, "error")
        return false
    end
    
    -- Prepare installation command
    local install_cmd = pm.install .. " " .. table.concat(missing_deps, " ")
    notify("Installing external dependencies: " .. install_cmd, "info")
    
    -- Run installation command
    local handle = io.popen(install_cmd .. " 2>&1")
    local result = handle:read("*a")
    local success = handle:close()
    
    if success then
        notify("External dependencies installed successfully!", "info")
        return true
    else
        notify("Failed to install dependencies: " .. result, "error")
        return false
    end
end

-- Auto-install dependencies if missing
function M.auto_install()
    local deps_ok, missing_deps = M.check_dependencies()
    if not deps_ok then
        vim.notify("Missing external dependencies: " .. table.concat(missing_deps, ", "), "warn")
        
        -- Ask user if they want to install
        local choice = vim.fn.input("Install missing dependencies automatically? (y/N): ")
        if choice:lower() == "y" or choice:lower() == "yes" then
            return M.install_dependencies(missing_deps)
        else
            vim.notify("Skipping automatic installation. You can run :DependencyInstall later.", "info")
            return false
        end
    end
    return true
end

-- Create user commands
function M.setup_commands()
    vim.api.nvim_create_user_command("DependencyCheck", function()
        local deps_ok, missing = M.check_dependencies()
        if deps_ok then
            vim.notify("All external dependencies are installed!", "info")
        else
            vim.notify("Missing dependencies: " .. table.concat(missing, ", "), "warn")
        end
    end, { desc = "Check external dependencies" })
    
    vim.api.nvim_create_user_command("DependencyInstall", function()
        local deps_ok, missing = M.check_dependencies()
        if deps_ok then
            vim.notify("All dependencies are already installed!", "info")
        else
            M.install_dependencies(missing)
        end
    end, { desc = "Install missing external dependencies" })
end

return M
