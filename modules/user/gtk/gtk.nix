{config, lib, pkgs, ...}:

{
    gtk = {
        enable = true;

        theme = {
            name = "Breeze Dark";
            package = pkgs.kdePackages.breeze;
        };
        
        font = {
            name = "Noto Sans Regular";
            size = 10;
        };

        cursorTheme = {
            name = "Bibata-Original-Classic";
            size = 20;
            package = pkgs.bibata-cursors;
        };

        iconTheme = {
            name = "Breeze Dark";
        };
    };
}