{config, lib, pkgs, inputs, ...}:

{
    programs.rofi = {
        enable = true;
        package = pkgs.emptyDirectory;
        theme = "Arc-Dark";

        settings = {
            location = "center";
            show-icons = true;
            sidebar-mode = true;
        };
    };
}