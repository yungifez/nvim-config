local function on_attach(bufnr)
  local api = require "nvim-tree.api"
  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', 'n', function()
    api.tree.change_root_to_node(api.tree.get_node_under_cursor())
    pcall(vim.api.nvim_win_set_cursor, vim.api.nvim_get_current_win(), { 2, 0 })
  end, opts('Set node as root'))

  vim.api.nvim_set_keymap('n', '<M-b>', ':NvimTreeToggle<CR>',
    { silent = true, noremap = true, desc = "Toggle file tree" })
end

return {
  'nvim-tree/nvim-tree.lua',
  opts = {},
  config = {
    disable_netrw = true,
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
  }
}
