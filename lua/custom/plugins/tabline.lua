return {
  'romgrk/barbar.nvim',
  dependencies = {
    'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
    'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
  },
  config = function()
    require('barbar').setup {
      icons = {
        buffer_index = true,
      },
    }

    vim.api.nvim_set_keymap('n', '<leader>n', ':BufferNext<CR>', { noremap = true, silent = true, desc = '[N]ext buffer' })
    vim.api.nvim_set_keymap('n', '<leader>p', ':BufferPrevious<CR>', { noremap = true, silent = true, desc = '[P]revious buffer' })

    for i = 1, 9 do
      vim.api.nvim_set_keymap('n', '<leader>' .. i, ':BufferGoto ' .. i .. '<CR>', { noremap = true, silent = true, desc = 'Go to buffer ' .. i })
    end

    vim.keymap.set('n', '<leader>nt', ':enew | execute "buffer " . bufnr("%")<CR>', { desc = '[N]ew [T]ab' })

    vim.api.nvim_create_user_command('CloseOtherTabs', function()
      vim.cmd 'BufferCloseAllButCurrentOrPinned'
    end, {})

    vim.keymap.set('n', '<leader>cot', '<cmd>CloseOtherTabs<CR>', { desc = '[C]lose [O]ther [T]abs' })
    vim.keymap.set('n', '<leader>ct', ':BufferClose<CR>', { desc = '[C]lose [T]ab' })
  end,
}
