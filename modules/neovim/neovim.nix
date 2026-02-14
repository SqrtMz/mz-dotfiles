{config, lib, pkgs, inputs, ...}:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;

        initLua = ''
            vim.o.tabstop = 4
            vim.o.shiftwidth = 4

            vim.o.clipboard = "unnamedplus"

            vim.o.signcolumn = "no"
            vim.o.number = true
            
            vim.o.termguicolors = true
            vim.o.mouse = "a"

			-- transparent background
			vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
			vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
			vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
			vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
        '';
    };
}