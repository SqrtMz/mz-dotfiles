{config, lib, pkgs, pkgs-stable, pkgs-prior-stable, inputs, ...}:

{
    home.username = "mz";
    home.homeDirectory = "/home/mz";

    targets.genericLinux.enable = true;

    targets.genericLinux.nixGL = {
        packages = inputs.nixgl.packages;
        defaultWrapper = "mesa";
        installScripts = ["mesa"];
        vulkan.enable = true;
    };

    imports = [
        ../../modules/user/firefox/firefox.nix
        ../../modules/user/hyprland/hyprland.nix
        ../../modules/user/kitty/kitty.nix
        ../../modules/user/neovim/neovim.nix
        ../../modules/user/rofi/rofi.nix
        ../../modules/user/themes/themes.nix
        ../../modules/user/satty/satty.nix
        ../../modules/user/waybar/waybar.nix
        ../../modules/user/wlogout/wlogout.nix
        ../../modules/user/zsh/zsh.nix
    ];

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
		android-tools
        btop
        brightnessctl
        (config.lib.nixGL.wrap pkgs.chromium)
		cubiomes-viewer
        (config.lib.nixGL.wrap pkgs.discord)
        fastfetch
        (config.lib.nixGL.wrap pkgs.freecad)
		(config.lib.nixGL.wrap pkgs.gimp3)
        (config.lib.nixGL.wrap pkgs.goverlay)
        grim
        (config.lib.nixGL.wrap pkgs.gthumb)
		hyprsome
		inkscape
		(config.lib.nixGL.wrap (pkgs.jetbrains.idea-ultimate.override { forceWayland = true; }))
        (config.lib.nixGL.wrap pkgs.krita)
		(config.lib.nixGL.wrap pkgs.libreoffice)
        mangohud
		(config.lib.nixGL.wrap pkgs.mcaselector)
        miktex
        ncdu
        networkmanagerapplet
        ntfs3g
        nvtopPackages.full
    	(config.lib.nixGL.wrap pkgs.obs-studio)
		(config.lib.nixGL.wrap pkgs.obsidian)
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
        (config.lib.nixGL.wrap pkgs.upscaler)
        unrar
        unzip
        usbutils
        vlc
	    vscode
        wev
        wl-clipboard
        xournalpp
		(config.lib.nixGL.wrap pkgs.youtube-music)

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
            package = pkgs.hyprpaper;

            settings = {
                splash = true;

                preload = [
                    "~/Pictures/Images & Videos/BG/TH6.png"
                    # "~/Pictures/Images & Videos/BG/TH6.png"
                ];

                wallpaper = [
                    "DP-4, ~/Pictures/Images & Videos/BG/TH6.png"
                    # "HDMI-A-2, ~/Pictures/Images & Videos/BG/TH6.png"
                ];
            };
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
    home.stateVersion = "25.05";
}