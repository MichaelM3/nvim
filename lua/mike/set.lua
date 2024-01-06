local function set_options(opts)
    for k, v in pairs(opts) do
        vim.opt[k] = v
    end
end

set_options({
    -- guicursor = ""
    cmdheight = 1,
    cursorline = true,
    cursorlineopt = "number",
    nu = true,
    relativenumber = true,
    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
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
    showtabline = 1
})

vim.opt.isfname:append("@-@")
vim.g.mapleader = " "
