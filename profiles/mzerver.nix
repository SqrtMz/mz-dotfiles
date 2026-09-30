{config, lib, pkgs, pkgs-stable, inputs, ...}:

{
	home.username = "mz";
	home.homeDirectory = "/home/mz";

	nixpkgs.config.allowUnfree = true;

	imports = [
		../modules/zsh/zsh.nix
	];

	home.packages = with pkgs; [
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