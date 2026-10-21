-- ~/.config/nvim/init.lua

local opt = vim.opt

vim.cmd.colorscheme("vim")

opt.number = true
opt.wrap = true
opt.linebreak = true
opt.cursorline = true
opt.colorcolumn = "80"

-- whitespace
opt.list = true
opt.listchars = { tab = ">-", trail = "␣" }

-- status line
-- left: short path and flags
-- sithg: filetype and position
opt.laststatus = 2
opt.statusline = [[%f %m%r%h%w%=%y %l:%c %p%% ]]

opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.shiftround = true

-- Per-language indendtation
-- ...
local indent_group = vim.api.nvim_create_augroup("filetype_indent", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = indent_group,
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 0
  end,
})
vim.api.nvim_create_autocmd("FileType", {
  group = indent_group,
  pattern = "java",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

opt.mouse = "a"

opt.scrolloff = 4
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- Esc clears search highlight

