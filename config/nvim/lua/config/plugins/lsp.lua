return {
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		config = function()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			-- Capabilities para nvim-cmp
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Lista de servidores LSP
			local servers = {
				ts_ls = {
					cmd = { "typescript-language-server", "--stdio" },
					filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "jsx", "tsx" },
				},
				lua_ls = {
					cmd = { "lua-language-server" },
					filetypes = { "lua" },
				},
				html = {
					cmd = {
						"/home/mingo/.local/share/nvim/mason/packages/html-lsp/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server",
						"--stdio",
					},
					filetypes = { "html", "templ" },
					init_options = {
						configurationSection = { "html", "css", "javascript" },
						embeddedLanguages = { css = true, javascript = true },
						provideFormatter = true,
					},
				},
				solargraph = {
					cmd = { "solargraph", "stdio" },
				},
				pylsp = { -- <-- Python LSP
					cmd = { "pylsp" },
					filetypes = { "python" },
				},
			}

			-- Registrar cada servidor usando la nueva API
			for name, opts in pairs(servers) do
				vim.lsp.config(name, vim.tbl_extend("force", { capabilities = capabilities }, opts))
				vim.lsp.enable(name)
			end

			-- Keymaps LSP usando LspAttach
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					local buf = args.buf

					-- Keymaps para buffers activos del LSP
					local opts = { noremap = true, silent = true, buffer = buf }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
					vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})
		end,
	},
}
