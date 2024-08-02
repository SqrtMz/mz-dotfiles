{config, lib, pkgs, inputs, ...}:

{
    imports = [
        ../../hardware-configuration.nix
        ../../modules/system/fonts.nix
        inputs.home-manager.nixosModules.default
    ];

    documentation.nixos.enable = false;

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        warn-dirty = false;
        auto-optimise-store = true;
    };

    nixpkgs.config.allowUnfree = true;

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "Mz";
    networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

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

    services.pipewire = {
        enable = true;
        pulse.enable = true;
    };

    # Enable touchpad support (enabled default in most desktopManager).
    # services.libinput.enable = true;

    users.users.mz = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [
        ];
    };

    home-manager = {
        extraSpecialArgs = {inherit inputs;};
        users = {
            "mz" = import ../user/mz.nix;
        };
    };

    environment.systemPackages = with pkgs; [
        android-tools
        fastfetch
        firefox
        flameshot
        fzf
        git
        github-desktop
        gparted
        grim
        heimdall-gui
        home-manager
        kdePackages.ark
        kdePackages.dolphin
        kdePackages.okular
        kdePackages.qtstyleplugin-kvantum
        kdePackages.qtsvg # Dolphin icons
        kdePackages.qtwayland
        lxde.lxsession # Polkit
        neovim
        networkmanagerapplet
        obs-studio
        rar
        unrar
        unzip
        vscode
        waydroid
        wget
        wl-clipboard
        xdg-desktop-portal-gtk # Desktop portal needed for OBS and Flameshot on Hyprland
        zip
    ];

    programs.zsh.enable = true;
    users.defaultUserShell = pkgs.zsh;

    programs.hyprland = {
        enable = true;
        portalPackage = pkgs.xdg-desktop-portal-hyprland; # Desktop portal needed for OBS and Flameshot on Hyprland
    };

    services = {
        displayManager.sddm = {
            enable = true;
            wayland.enable = true;
        };

        gvfs.enable = true; # Partitions on Dolphin
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
    networking.firewall.enable = false;

    # Copy the NixOS configuration file and link it from the resulting system
    # (/run/current-system/configuration.nix). This is useful in case you
    # accidentally delete configuration.nix.
    # system.copySystemConfiguration = true;

    system.stateVersion = "24.05";

}
