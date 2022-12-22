vim.cmd [[set termguicolors]]
require('plugins')

-- VIM SETTINGS ---------------------------------------------------------------------
vim.o.number = true
vim.o.showmatch = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.clipboard = 'unnamedplus'

vim.o.syntax = 'on'
vim.o.expandtab = true
vim.o.shiftwidth = 8
vim.bo.autoindent = true
vim.bo.smartindent = true

vim.o.backup = false
vim.bo.swapfile = false

vim.wo.cursorline = true

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- FIXING SOME TABLINE MOTHERFUCKERY --------------------------------------------
vim.api.nvim_create_autocmd('BufWinEnter', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      require'bufferline.api'.set_offset(31, 'FileTree')
    end
  end
})

vim.api.nvim_create_autocmd('BufWinLeave', {
  pattern = '*',
  callback = function()
    if vim.fn.expand('<afile>'):match('NvimTree') then
      require'bufferline.api'.set_offset(0)
    end
  end
})

-- KEYBINDS -------------------------------------------------------------------------
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Show/Hide tree
map("n", "<A-n>",":NvimTreeToggle<cr>", opts)
-- Move to previous/next tab
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
-- Re-order to previous/next tab
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
-- Kill current buffer
map('n', '<A-c>', '<Cmd>BufferClose!<CR>', opts)
-- Window split rebinds
map('n', '<A-b>', '<Cmd>split<CR>', {})
map('n', '<A-v>', '<Cmd>vsplit<CR>', {})
map('n', '<A-h>', '<Cmd>wincmd h<CR>', {})
map('n', '<A-j>', '<Cmd>wincmd j<CR>', {})
map('n', '<A-k>', '<Cmd>wincmd k<CR>', {})
map('n', '<A-l>', '<Cmd>wincmd l<CR>', {})
-- Terminal keybinds
map('t', '<Esc>', '<C-\\><C-n>', {})
