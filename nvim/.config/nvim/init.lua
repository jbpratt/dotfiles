vim.cmd.filetype({ args = { "plugin", "indent", "on" } })
vim.cmd.syntax("on")

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>w", ":w!<cr>")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- keep cursor in same location when joining lines
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<F1>", "<nop>")
vim.keymap.set("n", "Q", "<nop>")

-- yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- move groups of lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- maintain register when replacing
vim.keymap.set("x", "<leader>p", [["_dP]])

--- options
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.list = true
vim.opt.listchars:append "eol:¬"
vim.opt.listchars:append "tab:->"
vim.opt.listchars:append "trail:~"
vim.opt.listchars:append "extends:>"
vim.opt.listchars:append "precedes:<"
vim.opt.listchars:append "space:•"

--- setup lazy
if not vim.g.lazy_did_setup then
    vim.opt.runtimepath:prepend(vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
    require("lazy").setup("plugins", { ui = { border = "rounded" } })
end
