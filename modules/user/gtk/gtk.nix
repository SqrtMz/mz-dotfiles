{config, lib, pkgs, ...}:

{
    gtk = {
        enable = true;

        theme = {

        };
        
        font = {
            name = "Noto Sans Regular";
            size = 10;
        };

        cursorTheme = {
            name = "Bibata-Original-Classic";
            size = 20;
        };

        iconTheme = {
            name = "Breeze Dark";
        };
    }
}