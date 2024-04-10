return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'Issafalcon/neotest-dotnet',
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-dotnet' {
          dap = { justMyCode = false },
        },
        require 'neotest-plenary',
      },
    }
  end,
  vim.keymap.set('n', '<leader>te', ':Neotest summary toggle<CR>', { desc = '[T]est [E]xplorer', silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>rts', ':Neotest run suite=true<CR>', { desc = '[R]un [T]est [S]uite', silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>rtc', ':Neotest run<CR>', { desc = '[R]un [T]est [C]ase', silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>rtd', ':Neotest run strategy="dap"<CR>', { desc = '[R]un [T]est [D]ebug', silent = true, noremap = true }),
  vim.keymap.set('n', '<leader>rtf', ':Neotest run file=true<CR>', { desc = '[R]un [T]est [F]ile', silent = true, noremap = true }),
}
