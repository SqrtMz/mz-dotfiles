{config, lib, pkgs, inputs, ...}:

{
    home.username = "mz";
    home.homeDirectory = "/home/mz";

    targets.genericLinux.enable = true;

    nixGL.packages = inputs.nixgl.packages;
    nixGL.defaultWrapper = "mesa";
    nixGL.installScripts = ["mesa"];
    nixGL.vulkan.enable = true;

    imports = [
        ../../modules/user/firefox/firefox.nix
        ../../modules/user/hyprland/hyprland.nix
        ../../modules/user/kitty/kitty.nix
        ../../modules/user/neovim/neovim.nix
        ../../modules/user/rofi/rofi.nix
        ../../modules/user/themes/themes.nix
        ../../modules/user/waybar/waybar.nix
        ../../modules/user/wlogout/wlogout.nix
        ../../modules/user/zsh/zsh.nix
    ];

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
		android-tools
        (config.lib.nixGL.wrap pkgs.blender)
        btop
        brightnessctl
		cubiomes-viewer
        (config.lib.nixGL.wrap pkgs.discord)
        (config.lib.nixGL.wrap pkgs.duckstation)
        fastfetch
		(config.lib.nixGL.wrap pkgs.gimp3)
        (config.lib.nixGL.wrap pkgs.goverlay)
        grim
        (config.lib.nixGL.wrap pkgs.gthumb)
        (config.lib.nixGL.wrap pkgs.heroic)
		hyprsome
		inkscape
        (config.lib.nixGL.wrap pkgs.lutris)
        (config.lib.nixGL.wrap pkgs.krita)
		libreoffice
        mangohud
        ncdu
        networkmanagerapplet
        ntfs3g
        nvtopPackages.full
        nwg-displays
    	(config.lib.nixGL.wrap pkgs.obs-studio)
        opentabletdriver
        parabolic
        pavucontrol
		(config.lib.nixGL.wrap pkgs.pcsx2)
        playerctl
        (prismlauncher.override {jdks = [pkgs.emptyDirectory];})
        pyenv
		qbittorrent
		(config.lib.nixGL.wrap pkgs.rpcs3)
        slurp
        (config.lib.nixGL.wrap pkgs.steam)
        (config.lib.nixGL.wrap pkgs.upscaler)
        unrar
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
                };
            };
        };

        hyprpaper = {
            enable = true;
            package = pkgs.hyprpaper;

            settings = {
                splash = true;

                preload = [
                    "~/Pictures/Images & Videos/BG/THE.jpg"
                    "~/Pictures/Images & Videos/BG/TH6.png"
                ];

                wallpaper = [
                    "DP-4, contain:~/Pictures/Images & Videos/BG/THE.jpg"
                    "HDMI-A-2, ~/Pictures/Images & Videos/BG/TH6.png"
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
    home.stateVersion = "24.05";
}