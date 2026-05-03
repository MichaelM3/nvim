return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load when editing Lua files
		opts = {
			-- Optional: customize if needed (most users start with defaults)
			library = {
				-- Examples of extra triggers if you want certain libs always/pre-loaded
				-- { path = "${3rd}/luv/library", words = { "vim%.uv" } },  -- for vim.uv types
				-- "LazyVim",  -- if you use LazyVim
			},
			-- Optional: integrations (usually fine as default)
			integrations = {
				lspconfig = true, -- works great with your lspconfig setup
				cmp = {
					enabled = true, -- if you use nvim-cmp, adds lazydev as a source
				},
			},
		},
	},
	-- Important: disable neodev.nvim if you have it anywhere
	{ "folke/neodev.nvim", enabled = false },
}
