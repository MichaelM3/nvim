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
