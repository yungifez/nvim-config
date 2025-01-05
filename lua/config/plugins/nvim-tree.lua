-- custom mappings
-- vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
local detail = false
local dir = vim.fn.getcwd()
local oil = require("oil")
oil.setup({
    keymaps = {
        ["gd"] = {
            desc = "Toggle file detail view",
            callback = function()
                detail = not detail
                if detail then
                    oil.set_columns({ "icon", "permissions", "size", "mtime" })
                else
                    oil.set_columns({ "icon" })
                end
            end,
        },
    },
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory of current file" })
vim.keymap.set('n', '<M-->', function()
    oil.open(vim.fn.getcwd())
end, { silent = true, noremap = true, desc = "Toggle file tree" })
vim.keymap.set('n', '<M-b>', function()
    if vim.bo.filetype == 'oil' then
        dir = oil.get_current_dir()
        vim.cmd('bd')
    else
        oil.open(dir)
    end
end, { silent = true, noremap = true, desc = "Toggle file tree" })
