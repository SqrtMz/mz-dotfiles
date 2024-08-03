{config, lib, pkgs, inputs, ...}:

{
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true; 
        dedicatedServer.openFirewall = true;

        extraCompatPackages = with pkgs; [
            proton-ge-bin
        ];

        gamescopeSession = {
            enable = true;
        };
    };
}