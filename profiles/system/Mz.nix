{ config, lib, pkgs, ... }:

{
    imports = [
        ../../hardware-configuration.nix
        ../../modules/system/fonts.nix
    ];

    documentation.nixos.enable = false;

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        auto-optimise-store = true;
    };

    nixpkgs.config.allowUnfree = true;

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "Mz"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

    # Set your time zone.
    time.timeZone = "America/Bogota";

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    # i18n.defaultLocale = "en_US.UTF-8";
    # console = {
    #   font = "Lat2-Terminus16";
    #   keyMap = "us";
    #   useXkbConfig = true; # use xkb.options in tty.
    # };

    # Enable the X11 windowing system.
    # services.xserver.enable = true;

    # Configure keymap in X11
    # services.xserver.xkb.layout = "us";
    # services.xserver.xkb.options = "eurosign:e,caps:escape";

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    # hardware.pulseaudio.enable = true;
    # OR
    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.mz = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
        packages = with pkgs; [
        ];
    };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
        environment.systemPackages = with pkgs; [
        fastfetch
        firefox
        git
        github-desktop
        gparted
        home-manager
        kdePackages.dolphin
        kdePackages.qt6ct
        kdePackages.qtstyleplugin-kvantum
        kdePackages.qtwayland
        neovim
        networkmanagerapplet
        lxde.lxsession
        vscode
        wget
        wl-clipboard
    ];

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    programs.hyprland.enable = true;

    services = {
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    system.stateVersion = "24.05";

}
