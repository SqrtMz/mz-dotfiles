vim.g.loaded_node_provider=0; vim.g.loaded_perl_provider=0; vim.g.loaded_ruby_provider=0; vim.g.loaded_python3_provider=0
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.clipboard = "unnamedplus"

vim.o.signcolumn = "no"
vim.o.number = true

vim.o.termguicolors = true
vim.o.mouse = "a"

-- transparent background
vim.api.nvim_set_hl(0, 'Normal', 		{ bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', 	{ bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', 	{ bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', 		{ bg = 'none' })

-- user-associated plugin config {{{
-- require('mini.base16').setup({
--   palette = {
--     base00 = '#1e1e2e', base01 = '#181825', base02 = '#313244', base03 = '#89b4fa',
--     base04 = '#585b70', base05 = '#ffffff', base06 = '#f5e0dc', base07 = '#b4befe',
--     base08 = '#f38ba8', base09 = '#fab387', base0A = '#f9e2af', base0B = '#a6e3a1',
--     base0C = '#94e2d5', base0D = '#89b4fa', base0E = '#cba6f7', base0F = '#f2cdcd'
--   }
-- })
-- }}}
