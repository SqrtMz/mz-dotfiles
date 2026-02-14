{config, lib, pkgs, pkgs-stable, pkgs-prior-stable, inputs, ...}:

{
    home.username = "mz";
    home.homeDirectory = "/home/mz";

    targets.genericLinux = {
        enable = true;

        nixGL = {
            packages = inputs.nixgl.packages;
            defaultWrapper = "mesa";
            installScripts = ["mesa"];
            vulkan.enable = true;
        };
    };

    imports = [
        ../modules/firefox/firefox.nix
        ../modules/hyprland/hyprland.nix
        ../modules/kitty/kitty.nix
        ../modules/neovim/neovim.nix
        ../modules/rofi/rofi.nix
        ../modules/themes/themes.nix
        ../modules/satty/satty.nix
        ../modules/waybar/waybar.nix
        ../modules/wlogout/wlogout.nix
        ../modules/zsh/zsh.nix
    ];

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
		android-tools
        kdePackages.ark
        btop
        brightnessctl
        (config.lib.nixGL.wrap pkgs.chromium)
		(config.lib.nixGL.wrap pkgs.google-chrome)
		cubiomes-viewer
        (config.lib.nixGL.wrap pkgs.discord)
        kdePackages.dolphin
        fastfetch
		(config.lib.nixGL.wrap pkgs.gimp3)
        (config.lib.nixGL.wrap pkgs.goverlay)
        grim
        (config.lib.nixGL.wrap pkgs.gthumb)
		hyprsome
		inkscape
		(config.lib.nixGL.wrap (pkgs.jetbrains.idea.override { forceWayland = true; }))
        kdePackages.kdenlive
        (config.lib.nixGL.wrap pkgs.krita)
		(config.lib.nixGL.wrap pkgs.libreoffice)
        mangohud
		(config.lib.nixGL.wrap pkgs.mcaselector)
        (config.lib.nixGL.wrap pkgs-stable.miktex)
        ncdu
        networkmanagerapplet
        ntfs3g
        nvtopPackages.full
    	(config.lib.nixGL.wrap pkgs.obs-studio)
		(config.lib.nixGL.wrap pkgs.obsidian)
        kdePackages.okular
		opentabletdriver
        parabolic
        pavucontrol
        playerctl
        (prismlauncher.override {jdks = [pkgs.emptyDirectory];})
        pyenv
		qbittorrent
        slurp
        (config.lib.nixGL.wrap pkgs.steam)
		(config.lib.nixGL.wrap pkgs.telegram-desktop)
        (config.lib.nixGL.wrap pkgs.texstudio)
        (config.lib.nixGL.wrap pkgs-stable.upscaler)
        unrar
        (config.lib.nixGL.wrap pkgs.unityhub)
        unzip
        usbutils
        vlc
		vscode
        wev
        wl-clipboard
        xournalpp

        corefonts
        google-fonts
    ];

    services = {
        cliphist.enable = true;

        flameshot = {
            enable = true;
            package = pkgs.flameshot.override {
                enableWlrSupport = true;
            };

            settings = {  
                General = {
                    disabledTrayIcon = true;
                    uiColor = "#369B99";
                    allowMultipleGuiInstances = true;
                };
            };
        };

        hyprpaper = {
            enable = true;
            package = pkgs-stable.hyprpaper;

            settings = {
                splash = true;

                preload = [
                    "~/Pictures/Images & Videos/BG/TH6.png"
                    "~/Pictures/Images & Videos/BG/THE.jpg"
                ];

                wallpaper = [
                    "DP-1, ~/Pictures/Images & Videos/BG/THE.jpg"
                    "DP-2, ~/Pictures/Images & Videos/BG/TH6.png"
                ];
            };
        };

        syncthing = {
            enable = true;
            package = pkgs.syncthing;
        };
    };

    xdg = {
        enable = true;

        userDirs = {
            enable = true;
            createDirectories = true;
        };

        portal.config.common.default = [ "hyprland" ];
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.stateVersion = "26.05";
}