require("catppuccin").setup({
    flavour = "frappe",
    transparent_background = true,
    styles = {
        functions = { "italic " },
        keywords = { "bold" },
    },
    integrations = {
        cmp = true,
        mason = true,
        nvimtree = true,
        gitsigns = true,
        telescope = true,
    },
})
vim.cmd.colorscheme "catppuccin"
