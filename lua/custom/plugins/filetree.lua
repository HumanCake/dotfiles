return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = function()
    require('neo-tree').setup {
      window = {
        mappings = {
          ['<space>'] = 'none',
        },
      },
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
        },
      },
    }

    -- Toggle Neo-tree on startup
    vim.cmd [[
      autocmd VimEnter * Neotree toggle last

    ]]

    -- Keymap for manually toggling Neo-tree
    vim.keymap.set('n', '<leader>tn', ':Neotree toggle last<CR>', { noremap = true, silent = true, desc = '[T]oggle [N]eotree' })
  end,
}
