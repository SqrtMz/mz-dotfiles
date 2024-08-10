{config, lib, pkgs, inputs, ...}:

{
    programs.rofi = {
        enable = true;
        package = pkgs.rofi-wayland;
        theme = "Arc-Dark";
        location = "center";

        extraConfig = {
            show-icons = true;
            sidebar-mode = true;
        };
    };
}
