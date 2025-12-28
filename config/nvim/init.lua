require("config.options")
require("config.keymaps")
require("config.autocmd")
require("config.transparency")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("config.plugins", {
	defaults = { lazy = true },
	install = { colorscheme = { "tokyonight-night", "matteblack", "rose-pine" } },
	ui = { border = "rounded" },
})
