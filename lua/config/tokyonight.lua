require("tokyonight").setup({
  transparent = true,
  styles = {
    floats = "transparent",
    --on_colors = function(colors)
    -- colors.hint = colors.orange
    -- colors.error = "#ff0000"
    --end
  }
})

vim.cmd.colorscheme 'tokyonight'
