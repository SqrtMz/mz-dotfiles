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
        ../modules/firefox/firefox.nix
        ../modules/sway/sway.nix
        ../modules/neovim/neovim.nix
        ../modules/rofi/rofi.nix
        ../modules/themes/themes.nix
        ../modules/waybar/waybar.nix
        ../modules/wlogout/wlogout.nix
        ../modules/zsh/zsh.nix
    ];

    nixpkgs.config.allowUnfree = true;

    home.packages = with pkgs; [
		(config.lib.nixGL.wrap pkgs.alacritty)
        kdePackages.ark
		android-tools
        btop
        brightnessctl
        kdePackages.dolphin
        fastfetch
		(config.lib.nixGL.wrap pkgs.gimp)
        grim
        (config.lib.nixGL.wrap pkgs.gthumb)
		hyprsome
		libreoffice
        ncdu
        networkmanagerapplet
        ntfs3g
        nvtopPackages.full
        nwg-displays
    	(config.lib.nixGL.wrap pkgs.obs-studio)
        kdePackages.okular
        opentabletdriver
        pavucontrol
        playerctl
        pyenv
        slurp
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