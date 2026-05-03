-- Disable optional providers to avoid healthcheck warnings (re-enable if you need them)
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
-- vim.g.loaded_node_provider = 0

local function set_options(opts)
    for k, v in pairs(opts) do
        vim.opt[k] = v
    end
end

set_options({
    guicursor = "",
    cmdheight = 0,
    cursorline = true,
    cursorlineopt = "number",
    nu = true,
    relativenumber = true,
    tabstop = 2,
    softtabstop = 2,
    shiftwidth = 2,
    expandtab = true,
    smartindent = true,
    wrap = false,
    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,
    hlsearch = false,
    incsearch = true,
    termguicolors = true,
    scrolloff = 8,
    signcolumn = "yes",
    updatetime = 50,
    colorcolumn = "80",
    laststatus = 3,
    splitkeep = "screen",
    conceallevel = 0,
    -- showtabline = 2
})

-- Reload buffers when files change externally (e.g. OpenCode AI edits on disk)
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	group = vim.api.nvim_create_augroup("Autoread", { clear = true }),
	callback = function()
		if vim.fn.mode() ~= "c" then
			vim.cmd.checktime()
		end
	end,
	pattern = "*",
})

vim.opt.isfname:append("@-@")
vim.g.mapleader = " "
