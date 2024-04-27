return {
  'folke/tokyonight.nvim',
  priority = 1000,
  lazy = false,
  opts = {},
  config = {
    transparent = true,
    styles = {
      floats = "transparent",
      --on_colors = function(colors)
      -- colors.hint = colors.orange
      -- colors.error = "#ff0000"
      --end
    }
  }
}
