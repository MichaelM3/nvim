local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { import = "mike.plugins" }, { import = "mike.plugins.lsp" } }, {
    install = {
        colorscheme = { "rose-pine" },
    },
    ui = {
        border = "rounded",
    },
    checker = {
        enabled = true,
        notify = false,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
})

-- Lazy Commands
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>ll", "<cmd>Lazy<CR>", opts)
vim.keymap.set("n", "<leader>lu", "<cmd>Lazy update<CR>", opts)
vim.keymap.set("n", "<leader>lc", "<cmd>Lazy clean<CR>", opts)
vim.keymap.set("n", "<leader>ld", "<cmd>Lazy debug<CR>", opts)
