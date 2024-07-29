{ config, lib, pkgs, ... }:

{
    environment.packages = with pkgs; [
        btop
        bzip2
        diffutils
        fastfetch
        findutils
        git
        gnugrep
        gnupg
        gnused
        gnutar
        gzip
        home-manager
        hostname
        killall
        openssh
        neovim
        procps
        tzdata
        unzip
        utillinux
        xz
        zip
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