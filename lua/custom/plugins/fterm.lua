return {
  'numToStr/FTerm.nvim',
  config = function()
    -- Determine the OS and set the default cmd
    local os = vim.loop.os_uname().sysname
    local default_cmd
    if os == 'Darwin' then
      default_cmd = 'zsh'
    else
      -- Default to PowerShell.exe for non-macOS
      default_cmd = 'Powershell.exe'
    end

    require('FTerm').setup {
      dimensions = {
        height = 0.6,
        width = 0.6,
      },
      -- Use the OS-specific default cmd
      cmd = default_cmd,
    }

    -- Custom function to toggle FTerm with dynamic working directory
    local function toggle_ft_with_cwd()
      local cwd = vim.fn.getcwd()
      -- Update the cmd based on OS
      local cmd
      if os == 'Darwin' then
        -- This example assumes Alacritty, which might not directly support the same command structure
        -- You'd typically use a shell command to cd into the directory
        cmd = 'zsh' -- You might need a different approach for cwd with Alacritty or your terminal
      else
        -- Command for Windows with PowerShell
        cmd = 'Powershell.exe -NoLogo -NoExit -Command "cd \'' .. cwd .. '\'"'
      end
      require('FTerm'):setup {
        cmd = cmd,
      }
      -- Toggle FTerm after updating the command
      require('FTerm').toggle()
    end

    -- Keymap to use the custom toggle function
    vim.keymap.set('n', '<leader>tt', toggle_ft_with_cwd, { noremap = true, silent = true, desc = '[T]oggle [T]erminal' })
  end,
}
