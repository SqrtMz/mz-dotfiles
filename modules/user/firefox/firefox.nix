{config, lib, pkgs, inputs, ...}:

{
    programs.firefox = {
        enable = true;

        profiles."Mz" = {
            id = 0;
            name = "Mz";
            isDefault = true;

            extraConfig = ./user.js
        };
    };
}