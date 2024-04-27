local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup({})

vim.keymap.set("n", "<C-a>", function() harpoon:list():add() end, { desc = "Append to harpoon" })

vim.keymap.set("n", "<M-u>", function() harpoon:list():select(1) end, { desc = "Go to harpoon list item 1" })
vim.keymap.set("n", "<M-i>", function() harpoon:list():select(2) end, { desc = "Go to harpoon list item 2" })
vim.keymap.set("n", "<M-o>", function() harpoon:list():select(3) end, { desc = "Go to harpoon list item 3" })
vim.keymap.set("n", "<M-p>", function() harpoon:list():select(4) end, { desc = "Go to harpoon list item 4" })

vim.keymap.set("n", "du", function()
  harpoon:list():remove_at(1)
  print("Deleted item 1 in harpoon")
end)
vim.keymap.set("n", "di", function()
  harpoon:list():remove_at(2)
  print("Deleted item 2 in harpoon")
end)
vim.keymap.set("n", "do", function()
  harpoon:list():remove_at(3)
  print("Deleted item 3 in harpoon")
end)
vim.keymap.set("n", "dp", function()
  harpoon:list():remove_at(4)
  print("Deleted item 4 in harpoon")
end)

-- Toggle previous & next buffers stored within Harpoon list
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}
  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.value)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<C-e>", function() toggle_telescope(harpoon:list()) end,
  { desc = "Open harpoon window" })
