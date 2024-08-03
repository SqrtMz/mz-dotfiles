{config, lib, pkgs, inputs, ...}:

{
    programs.steam = {
        enable = true;

        gamescopeSession = {
            enable = true;
        };
    };
}