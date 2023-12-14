-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


local function on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

end
  -- custom mappings
--  vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,opts('Up'))
 -- vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
require("nvim-tree").setup({

  on_attach = on_attach,

  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 25,
    side = 'right'
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

local function open_nvim_tree()

  -- open the tree
  require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', {silent = true, noremap = true} )
vim.api.nvim_set_keymap('n', 'ft', ':NvimTreeFocu<CR>', {silent = true, noremap = true} )
