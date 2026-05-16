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
		(config.lib.nixGL.wrap pkgs.blender)
		(config.lib.nixGL.wrap pkgs.google-chrome)
		cubiomes-viewer
		(config.lib.nixGL.wrap pkgs.mcaselector)
        nixd
        nixfmt
		opentabletdriver
        parabolic
        (config.lib.nixGL.wrap pkgs-stable.upscaler)

        corefonts
        google-fonts
    ];

    services = {
        cliphist.enable = true;
        cliphist.package = pkgs.emptyDirectory;

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