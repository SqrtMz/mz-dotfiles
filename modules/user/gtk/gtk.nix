{config, lib, pkgs, ...}:

{
    gtk = {
        enable = true;

        theme = {
            name = "Breeze-Dark";
            package = pkgs.breeze-gtk;
        };
        
        font = {
            name = "Noto Sans Regular";
            size = 10;
        };

        iconTheme = {
            name = "Whitesur-dark";
            package = pkgs.Whitesur-icon-theme;
        };
    };

    home.pointerCursor = {
        name = "Bibata-Original-Classic";
        size = 20;
        package = pkgs.bibata-cursors;
        gtk.enable = true;
    };
}
