{config, lib, pkgs, ...}:

{
    home.file.".config/Kvantum/kvantum.kvconfig" = {
        source = ./config;
        recursive = true;
    };
}