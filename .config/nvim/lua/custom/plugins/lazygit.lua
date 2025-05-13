return {
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
  },
  vim.keymap.set('n', '<leader>tg', ':LazyGitCurrentFile<CR>', { desc = '[T]oggle lazy [G]it', noremap = true, silent = true }),
}
