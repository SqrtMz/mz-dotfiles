{config, lib, pkgs, inputs, ...}:

{
    programs.neovim = {
        enable = true;
        defaultEditor = true;

        extraLuaConfig = ''
            vim.o.tabstop = 4
            vim.o.shiftwidth = 4

            vim.o.clipboard = "unnamedplus"

            vim.o.signcolumn = "no"
            vim.o.number = true
            
            vim.o.termguicolors = true
            vim.o.mouse = "a"
        '';

        # plugins = with pkgs.vimPlugins; [
        #     gitsigns-nvim
        # ];
    };
}