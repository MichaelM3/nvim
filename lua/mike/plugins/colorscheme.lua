return {
    {
        "rebelot/kanagawa.nvim",
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("kanagawa").setup({
                compile = true,  -- enable compiling the colorscheme
                undercurl = true, -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true },
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = true,    -- do not set background color
                dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
                terminalColors = true, -- define vim.g.terminal_color_{0,17}
                colors = {             -- add/modify theme and palette colors
                    palette = {},
                    theme = {
                        all = {
                            ui = {
                                bg_gutter = "none"
                            }
                        }
                    },
                },
                overrides = function(colors) -- add/modify highlights
                    local theme = colors.theme
                    return {
                        NormalFloat = { bg = "none" },
                        FloatBorder = { bg = "none" },
                        FloatTitle = { bg = "none" },

                        -- Save an hlgroup with dark background and dimmed foreground
                        -- so that you can use it where your still want darker windows.
                        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
                        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

                        -- Popular plugins that open floats will link to NormalFloat by default;
                        -- set their background accordingly if you wish to keep them dark and borderless
                        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
                    }
                end,
                theme = "dragon",    -- Load "wave" theme when 'background' option is not set
                background = {       -- map the value of 'background' option to a theme
                    dark = "dragon", -- try "dragon" !
                    light = "lotus"
                },
            })
            vim.cmd([[colorscheme kanagawa]])
        end
    },
    -- {
    --     "bluz71/vim-nightfly-guicolors",
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         -- load the colorscheme here
    --         vim.g.nightflyTransparent = true
    --         vim.cmd([[colorscheme nightfly]])
    --     end,
    -- },
    -- {
    --   "folke/tokyonight.nvim",
    --   priority = 1000, -- make sure to load this before all the other start plugins
    --   config = function()
    --     local bg = "#011628"
    --     local bg_dark = "#011423"
    --     local bg_highlight = "#143652"
    --     local bg_search = "#0A64AC"
    --     local bg_visual = "#275378"
    --     local fg = "#CBE0F0"
    --     local fg_dark = "#B4D0E9"
    --     local fg_gutter = "#627E97"
    --     local border = "#547998"
    --
    --     require("tokyonight").setup({
    --       style = "night",
    --       on_colors = function(colors)
    --         colors.bg = bg
    --         colors.bg_dark = bg_dark
    --         colors.bg_float = bg_dark
    --         colors.bg_highlight = bg_highlight
    --         colors.bg_popup = bg_dark
    --         colors.bg_search = bg_search
    --         colors.bg_sidebar = bg_dark
    --         colors.bg_statusline = bg_dark
    --         colors.bg_visual = bg_visual
    --         colors.border = border
    --         colors.fg = fg
    --         colors.fg_dark = fg_dark
    --         colors.fg_float = fg
    --         colors.fg_gutter = fg_gutter
    --         colors.fg_sidebar = fg_dark
    --       end,
    --     })
    --     -- load the colorscheme here
    --     vim.cmd([[colorscheme tokyonight]])
    --   end,
    -- },
}
