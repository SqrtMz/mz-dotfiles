{ config, lib, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        corefonts
        google-fonts
        nerdfonts
    ];
}