-- Built-in commenting (Nvim 0.10+) does not apply this treesitter-aware commentstring
-- hook for TS/TSX inside JSX; keep Comment.nvim for correct block comments there.
return {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        -- import comment plugin safely
        local comment = require("Comment")

        -- enable comment
        comment.setup({
            -- for commenting tsx and jsx files
            pre_hook = function()
                local get_option = vim.filetype.get_option
                vim.filetype.get_option = function(filetype, option)
                    return option == 'commentstring' and vim.treesitter.get_node() or get_option(filetype, option)
                end
            end,
        })
    end,
}
