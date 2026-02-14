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
        kdePackages.ark
		(config.lib.nixGL.wrap pkgs.google-chrome)
		cubiomes-viewer
        kdePackages.dolphin
		hyprsome
		(config.lib.nixGL.wrap (pkgs.jetbrains.idea.override { forceWayland = true; }))
        kdePackages.kdenlive
		(config.lib.nixGL.wrap pkgs.libreoffice)
		(config.lib.nixGL.wrap pkgs.mcaselector)
        (config.lib.nixGL.wrap pkgs-stable.miktex)
        kdePackages.okular
		opentabletdriver
        parabolic
        (prismlauncher.override {jdks = [pkgs.emptyDirectory];})
        (config.lib.nixGL.wrap pkgs.texstudio)
        (config.lib.nixGL.wrap pkgs-stable.upscaler)
        (config.lib.nixGL.wrap pkgs.unityhub)

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