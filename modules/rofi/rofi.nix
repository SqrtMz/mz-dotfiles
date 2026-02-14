{config, lib, pkgs, inputs, ...}:

{
    programs.rofi = {
        enable = true;
        package = pkgs.emptyDirectory;
        theme = "Arc-Dark";
        location = "center";

        extraConfig = {
            show-icons = true;
            sidebar-mode = true;
        };
    };
}