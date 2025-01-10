vim.opt.encoding = "utf-8"
vim.opt.compatible = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.omnifunc = "v:vim.lsp.omnifunc"
vim.opt.undofile = true
vim.opt.cursorline = true
vim.g.mapleader = "ü"
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.opt.wildmode="longest:full"

--Better indenting, indentexpr outsourced to lua/utils.lua
vim.cmd([[filetype indent off]])
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
