{config, lib, pkgs, inputs, ...}:

{
    programs.neovim = {
        enable = true;

        defaultEditor = true;

        plugins = with pkgs.vimPlugins; [
            wtf-nvim
        ];
    };
}