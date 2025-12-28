{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.g.tokyonight_style = "night"
    vim.g.tokyonight_colors = {
      fg = "#e5e5e5",
      fg_dark = "#bfbfbf",
      border = "#ffffff",
    }
    vim.cmd.colorscheme("tokyonight")
  end,
}
