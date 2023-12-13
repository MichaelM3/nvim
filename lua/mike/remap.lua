local map = vim.keymap.set

-- Explorer
map("n", "<leader>pv", vim.cmd.Ex)
map("i", "jk", "<ESC>")
map("n", "<leader>q", "<cmd>q<CR>")
map("n", "<leader>w", "<cmd>w!<CR>")

-- Move whole line
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Move current line to previous line with space
map("n", "J", "mzJ`Z")

-- Jump to middle of page (Keeps cursor centered)
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Next and previous search (Keeps cursor centered)
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Can paste over word, and not lose clipboard register of word
map("x", "<leader>p", "\"_dP")

-- Access system clipboard and copy
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

-- Rebind Ctrl-c to the ESC key
map("i", "<C-c>", "<ESC>")

-- Unbind Q to exit
map("n", "Q", "<nop>")

-- Switch project with tmux session
map("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>")

-- Format
map("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Quickfix list commands
map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace all occurrences of hovered word
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Pane Controls
map("n", "<leader>wv", "<C-w>v")
map("n", "<leader>wh", "<C-w>s")
map("n", "<leader>wc", "<C-w>c")
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Bufferline Remaps
map("n", "<S-h>", "<cmd>bprev<CR>")
map("n", "<S-l>", "<cmd>bnext<CR>")
map("n", "<leader>c", "<cmd>bd<CR>")
