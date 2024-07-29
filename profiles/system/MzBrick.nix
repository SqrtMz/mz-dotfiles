{ config, lib, pkgs, ... }:

{
    environment.packages = with pkgs; [
        neovim
        procps
        killall
        diffutils
        findutils
        utillinux
        tzdata
        hostname
        gnugrep
        gnupg
        gnused
        gnutar
        bzip2
        gzip
        xz
        zip
        unzip
    ];

    # Backup etc files instead of failing to activate generation if a file already exists in /etc
    environment.etcBackupExtension = ".bak";

    # Read the changelog before changing this value
    system.stateVersion = "24.05";

    # Set up nix for flakes
    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';

    # Set your time zone
    time.timeZone = "America/Bogota";
}