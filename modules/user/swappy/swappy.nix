{config, lib, pkgs, pkgs-stable, pkgs-prior-stable, inputs, ...}:

{
    home.file.".config/swappy/config".source = ./config;
}