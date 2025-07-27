{config, lib, pkgs, inputs, ...}:

{
    qt = {
        enable = true;
        platformTheme.name = "qtct"; # QT_QPA_PLATFORMTHEME
        # style.name = "qt6ct"; # QT_STYLE_OVERRIDE
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