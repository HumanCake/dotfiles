-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    local function get_netcoredbg_path()
      local mason_package_path = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg'
      -- Adjust for macOS and Linux (Unix)
      if vim.fn.has 'mac' == 1 then
        return mason_package_path .. '/netcoredbg'
      elseif vim.fn.has 'unix' == 1 then
        return mason_package_path .. '/netcoredbg'
      -- Default to Windows path
      else
        return mason_package_path .. '\\netcoredbg.exe'
      end
    end

    require('mason-nvim-dap').setup {

      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      -- Update this to ensure that you have the debuggers for the langs you want
      ensure_installed = {
        'coreclr',
      },
      automatic_installation = true,
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    dap.listeners.after.event_initialized['dap_k_mapping'] = function()
      vim.keymap.set('n', 'K', function()
        require('dap.ui.widgets').hover()
      end, { buffer = true, desc = 'Inspect variable value' })
    end

    dap.listeners.before.event_terminated['clear_dap_k_mapping'] = function()
      vim.keymap.del('n', 'K', { buffer = true })
    end

    dap.listeners.before.event_exited['clear_dap_k_mapping'] = function()
      vim.keymap.del('n', 'K', { buffer = true })
    end
    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.adapters.coreclr = {
      type = 'executable',
      command = get_netcoredbg_path(), -- Update this path to your netcoredbg executable
      args = { '--interpreter=vscode' },
    }
    dap.adapters.netcoredbg = dap.adapters.coreclr
  end,
}
