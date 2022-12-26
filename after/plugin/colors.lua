-- require('onedark').setup {
    -- style = 'darker',
    -- transparent = true
-- }

-- require('onedark').load()

-- function ColorMyPencils(color)
	-- color = color or "onehalfdark"
	-- vim.cmd.colorscheme(color)

	-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- end

-- ColorMyPencils()

require('tokyonight').setup({
	style = "night",
    transparent = true
})
-- Lua
vim.cmd[[colorscheme tokyonight]]
vim.cmd[[hi NvimTreeNormal guibg=NONE ctermbg=NONE]]
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
