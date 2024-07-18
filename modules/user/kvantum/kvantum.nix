{config, lib, pkgs, ...}:

{
    home.file.".config/Kvantum/" = {
        source = ./themes;
        recursive = true;
    };
}