vim.keymap.del("i", "<Tab>")
vim.keymap.del("s", "<Tab>")

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<left>", '<cmd>echo "USE h TO MOVE"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "USE l TO MOVE"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "USE k TO MOVE"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "USE j TO MOVE"<CR>')

vim.keymap.set("n", "<S-Tab>", ":bnext<CR>", { desc = "Next buffer" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

vim.keymap.set("n", "<leader>p", function()
	vim.cmd("write")
	local file = vim.fn.expand("%")
	vim.cmd("split | terminal python3 " .. file)
end, { desc = "Run current file with Python" })

---------- START TELESCOPE CMDS ----------
-- CMD TO SEARCH INSIDE .CONFIG FOLDER
vim.keymap.set("n", "<leader>fc", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.expand("~/.config"),
		hidden = true,
	})
end, { desc = "Find in CONFIG" })

-- CMD TO SEARCH INSIDE HOME FOLDER
vim.keymap.set("n", "<leader>fh", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.expand("~/"),
		hidden = true,
	})
end, { desc = "Find in HOME" })

-- CMD TO SEARCH INSIDE DEV FOLDER
vim.keymap.set("n", "<leader>fd", function()
	require("telescope.builtin").find_files({
		cwd = vim.fn.expand("~/dev"),
		hidden = true,
	})
end, { desc = "Find in DEV" })
---------- END TELESCOPE CMDS ----------

---------- START MINI-SURROUND CMDS ----------
vim.keymap.set("n", "sw", 'saiw"', { desc = "Surround word with quotes", remap = true })
---------- END MINI-SURROUND CMDS ----------
