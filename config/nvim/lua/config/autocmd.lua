vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = vim.api.nvim_create_augroup("LspFormatOnSave", { clear = true }),
	callback = function(event)
		local clients = vim.lsp.get_clients({ bufnr = event.buf })
		for _, client in ipairs(clients) do
			if client.supports_method("textDocument/formatting") then
				vim.lsp.buf.format({ bufnr = event.buf, timeout_ms = 500 })
				break
			end
		end
	end,
})

vim.api.nvim_create_user_command("W", "w", {})
