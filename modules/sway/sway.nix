{config, lib, pkgs, inputs, ...}:

{
    home.file.".config/sway/config".source = ./config;
}