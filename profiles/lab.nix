{config, lib, pkgs, inputs, ...}:

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

	nix = {
		gc = {
			automatic = true;
			options = "--delete-older-than 1d";
		};
	};

    nixpkgs.config.allowUnfree = true;

    imports = [
        ../modules/sway/sway.nix
        ../modules/neovim/neovim.nix
        ../modules/rofi/rofi.nix
        ../modules/themes/themes.nix
        ../modules/waybar/waybar.nix
        ../modules/wlogout/wlogout.nix
        ../modules/zsh/zsh.nix
    ];

    home.packages = with pkgs; [
        corefonts
        google-fonts
    ];

    xdg = {
        enable = true;

        userDirs = {
            enable = true;
            createDirectories = true;
        };
    };
    
    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.stateVersion = "25.05";
}