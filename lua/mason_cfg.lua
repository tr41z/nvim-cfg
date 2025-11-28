require("mason").setup()
local mason_lspconfig = require("mason-lspconfig")
mason_lspconfig.setup({ automatic_installation = true })

-- Only configure valid LSP servers; skip formatters/tools like stylua
for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
	local ok, _ = pcall(function()
		vim.lsp.config(server).setup({})
	end)
	-- skip servers that fail (like stylua)
end

-- LSP keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	end
})

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = cmp.mapping.select_next_item(),
		['<S-Tab>'] = cmp.mapping.select_prev_item(),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	})
})

-- Make sure LSP servers provide completion capability
local capabilities = require('cmp_nvim_lsp').default_capabilities()
for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
	local ok, _ = pcall(function()
		vim.lsp.config(server).setup({ capabilities = capabilities })
	end)
end
