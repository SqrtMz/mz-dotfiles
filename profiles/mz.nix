{config, lib, pkgs, pkgs-stable, inputs, ...}:

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
		../modules/rofi/rofi.nix
		../modules/themes/themes.nix
		../modules/satty/satty.nix
		../modules/waybar/waybar.nix
		../modules/wlogout/wlogout.nix
		../modules/zsh/zsh.nix
	];

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

	xdg = {
		enable = true;

		userDirs = {
			enable = true;
			createDirectories = true;
		};
	};

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
	home.stateVersion = "26.05";
}