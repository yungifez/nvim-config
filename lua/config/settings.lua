-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
--vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Set color scheme
vim.cmd.colorscheme 'moonfly'

-- let vim autoread and autowrite
vim.opt.autowrite = true
vim.opt.autoread = true

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- set spaces and tab
vim.opt.tabstop = 4    --a tab should look like 4 spaces
vim.o.expandtab = true --use spaces instead of tabs
vim.o.softtabstop = 4  -- number of spaces inserted when tab is pressed
vim.o.shiftwidth = 4   -- number of spaces when indenting
vim.o.smartindent = true
vim.o.autoindent = true

-- prevent cursor from sticking to the bottom
vim.o.scrolloff = 5

-- set relative line numbers
vim.opt.relativenumber = true

vim.opt.cursorline = true

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
