{config, lib, pkgs, inputs, ...}:

{
    qt = {
        enable = true;
        platformTheme.name = "gtk";
        style.name = "kvantum";
        style.package = pkgs.libsForQt5.qtstyleplugin-kvantum;
    };

    home.file.".config/Kvantum/" = {
        source = ./kvantum;
        recursive = true;
    };

    gtk = {
        enable = true;

        theme = {
            name = "Breeze-Dark";
            package = pkgs.kdePackages.breeze-gtk;
        };
        
        font = {
            name = "Noto Sans Regular";
            size = 10;
        };

        iconTheme = {
            name = "WhiteSur-dark";
            package = pkgs.whitesur-icon-theme;
        };
    };

    home.pointerCursor = {
        name = "Bibata-Original-Classic";
        size = 20;
        package = pkgs.bibata-cursors;
        gtk.enable = true;
    };
}
