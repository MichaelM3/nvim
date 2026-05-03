-- Parser install + TS highlight via tree-sitter-manager (Neovim 0.12+ core treesitter).
-- Note: nvim-treesitter's experimental `indent = { enable = true }` is not in core yet
-- (no vim.treesitter.indentexpr); indentation falls back to filetype/smart/cindent rules.
return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	config = function()
		require("tree-sitter-manager").setup({
			ensure_installed = {
				"json",
				"javascript",
				"typescript",
				"tsx",
				"sql",
				"yaml",
				"html",
				"css",
				"prisma",
				"markdown",
				"markdown_inline",
				"graphql",
				"bash",
				"lua",
				"vim",
				"dockerfile",
				"gitignore",
				"query",
				"c_sharp",
			},
			auto_install = true,
		})
	end,
}
