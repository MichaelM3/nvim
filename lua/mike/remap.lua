local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Explorer
-- keymap("n", "<leader>pv", vim.cmd.Ex)
keymap("i", "jk", "<ESC>", opts)
keymap("n", "<leader>q", "<cmd>q<CR>", opts)
keymap("n", "<leader>w", "<cmd>w!<CR>", opts)

-- Move whole line
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

-- Move current line to previous line with space
keymap("n", "J", "mzJ`Z", opts)

-- Jump to middle of page (Keeps cursor centered)
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- Next and previous search (Keeps cursor centered)
keymap("n", "n", "nzzzv", opts)
keymap("n", "N", "Nzzzv", opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Can paste over word, and not lose clipboard register of word
keymap("x", "<leader>p", "\"_dP", opts)

-- Access system clipboard and copy
keymap("n", "<leader>y", "\"+y", opts)
keymap("v", "<leader>y", "\"+y", opts)
keymap("n", "<leader>Y", "\"+Y", opts)

-- Rebind Ctrl-c to the ESC key
keymap("i", "<C-c>", "<ESC>", opts)

-- Unbind Q to exit
keymap("n", "Q", "<nop>", opts)

-- Switch project with tmux session
keymap("n", "<C-f>", "<cmd>silent !tmux new tmux-sessionizer<CR>", opts)

-- Format
keymap("n", "<leader>f", function()
    vim.lsp.buf.format()
end, opts)

keymap("n", "<leader>W", "<cmd>set wrap!<CR>", opts)

-- Quickfix list commands
keymap("n", "<C-k>", "<cmd>cnext<CR>zz", opts)
keymap("n", "<C-j>", "<cmd>cprev<CR>zz", opts)
keymap("n", "<leader>k", "<cmd>lnext<CR>zz", opts)
keymap("n", "<leader>j", "<cmd>lprev<CR>zz", opts)

-- Replace all occurrences of hovered word
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], opts)

-- Pane Controls
keymap("n", "<leader>wv", "<C-w>v", opts)
keymap("n", "<leader>wh", "<C-w>s", opts)
keymap("n", "<leader>wc", "<C-w>c", opts)
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Bufferline Remaps
keymap("n", "<S-h>", "<cmd>bprev<CR>", opts)
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<leader>c", "<cmd>bd<CR>", opts)

-- Terminal Nav Mode
keymap("t", "<C-;>", "<C-\\><C-n>", opts)
