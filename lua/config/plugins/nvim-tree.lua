-- custom mappings
-- vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = require 'nvim-tree.api'.tree.open })
