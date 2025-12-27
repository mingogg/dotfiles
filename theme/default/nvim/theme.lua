return {
	{
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.tokyonight_style = "night"
      vim.cmd.colorscheme("tokyonight")
    end,
	},
}
