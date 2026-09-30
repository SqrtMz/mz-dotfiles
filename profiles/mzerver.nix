{config, lib, pkgs, pkgs-stable, inputs, ...}:

{
	home.username = "mz";
	home.homeDirectory = "/home/mz";

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
		cubiomes-viewer
		(config.lib.nixGL.wrap pkgs.mcaselector)

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