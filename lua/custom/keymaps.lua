-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

local wk = require 'which-key'
-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Move lines up and down
vim.keymap.set('n', 'J', ':m .+1<CR>==')
vim.keymap.set('n', 'K', ':m .-2<CR>==')
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Reset buffer to saved file with <Leader>dr
vim.keymap.set('n', '<Leader>dr', ':e!<CR>', { desc = '[D]ocument [R]eset' })

wk.add {
  { '<leader>t', group = '[T]oggle' },
  { '<leader>t_', hidden = true },
}
-- Toggle line numbers with <leader>tl
vim.keymap.set('n', '<leader>tl', ToggleLineNumbers, { desc = '[T]oggle [L]ine Numbers' })

-- Open and close terminal window
local terminal_window = nil

vim.keymap.set('n', '<leader>tt', function()
  if terminal_window and vim.api.nvim_win_is_valid(terminal_window) then
    vim.api.nvim_win_close(terminal_window, true)
    terminal_window = nil
  else
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd 'J'
    vim.api.nvim_win_set_height(0, 15)
    terminal_window = vim.api.nvim_get_current_win()
  end
end)

-- Navigate tabs
for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, function()
    vim.cmd('tabn' .. i)
  end, { silent = true })
  wk.add {
    { '<leader>' .. i, hidden = true },
  }
end

vim.keymap.set('n', '<leader>pb', function()
  vim.cmd 'bprevious'
end, { desc = '[P]revious [B]uffer' })
vim.keymap.set('n', '<leader>nb', function()
  vim.cmd 'bnext'
end, { desc = '[N]ext [B]uffer' })
