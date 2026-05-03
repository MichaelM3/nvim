-- Core TS + tree-sitter-manager: parsers/queries come from Nvim runtime + installed parsers.
-- nvim-treesitter-endwise attaches via vim.treesitter on Nvim 0.9+ (no nvim-treesitter plugin required).
-- nvim-ts-autotag uses the same parser APIs.
return {
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup({})
		end,
	},
	{
		"rrethy/nvim-treesitter-endwise",
		event = { "BufReadPre", "BufNewFile" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
			latex = { enabled = false },
		},
		ft = { "markdown", "Avante" },
	},
}
