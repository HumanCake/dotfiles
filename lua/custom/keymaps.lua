-- Move lines up and down
vim.keymap.set('n', 'J', ':m .+1<CR>==')
vim.keymap.set('n', 'K', ':m .-2<CR>==')
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")

-- Reset buffer to saved file with <Leader>r
vim.keymap.set('n', '<Leader>dr', ':e!<CR>', { desc = '[D]ocument [R]eset' })
