-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local nvimTree = require("nvim-tree")
local api = require "nvim-tree.api"

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)
  vim.keymap.set('n', 'n', function()
    api.tree.change_root_to_node(api.tree.get_node_under_cursor())
    pcall(vim.api.nvim_win_set_cursor, vim.api.nvim_get_current_win(), { 2, 0 })
  end, opts('Set node as root'))
end
-- custom mappings
-- vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
nvimTree.setup({

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
})

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = api.tree.open })

vim.api.nvim_set_keymap('n', '<M-b>', ':NvimTreeToggle<CR>', { silent = true, noremap = true, desc = "Toggle file tree" })
