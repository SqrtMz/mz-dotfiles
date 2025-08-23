{config, lib, pkgs, pkgs-stable, pkgs-prior-stable, inputs, ...}:

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
        ../../modules/user/satty/satty.nix
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
        (config.lib.nixGL.wrap pkgs.chromium)
		cubiomes-viewer
        (config.lib.nixGL.wrap pkgs.discord)
        fastfetch
		(config.lib.nixGL.wrap pkgs.gimp3)
        (config.lib.nixGL.wrap pkgs.goverlay)
        grim
        (config.lib.nixGL.wrap pkgs.gthumb)
        (config.lib.nixGL.wrap pkgs.heroic)
		hyprsome
		inkscape
		jetbrains.idea-ultimate
		jetbrains.pycharm-professional
        (config.lib.nixGL.wrap pkgs.lutris)
        (config.lib.nixGL.wrap pkgs.krita)
		libreoffice
        mangohud
		(config.lib.nixGL.wrap pkgs.mcaselector)
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
		(config.lib.nixGL.wrap pkgs.telegram-desktop)
        (config.lib.nixGL.wrap pkgs.upscaler)
        unrar
        usbutils
        vlc
	    vscode
        wev
        wl-clipboard
        xournalpp
		(config.lib.nixGL.wrap pkgs.youtube-music)

		(config.lib.nixGL.wrap pkgs.mcpelauncher-ui-qt)

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

    # nixpkgs.overlays = [
    #     (final: prev: {
    #         qt6ct = prev.qt6ct.overrideAttrs (old: {

    #             src = pkgs.fetchFromGitHub {
    #                 owner = "ilya-fedin";
    #                 repo = "qt6ct";
    #                 rev = "26b539af69cf997c6878d41ba75ad7060b20e56e";
    #                 sha256 = "sha256-ePY+BEpEcAq11+pUMjQ4XG358x3bXFQWwI1UAi+KmLo=";
    #             };

    #         });

    #         qt6ct-kde = final.qt6ct;
    #     })
    # ];
    
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
}
