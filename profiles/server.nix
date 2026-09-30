{ inputs, config, pkgs, ... }:

{
	home.username = "debian";
	home.homeDirectory = "/home/debian";

	nixpkgs.config.allowUnfree = true;

	imports = [
		../modules/zsh/zsh.nix
		../modules/neovim/neovim.nix
	];

	home.packages = with pkgs; [
		btop
		dig
		fastfetch
		uv
	];

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
	home.stateVersion = "25.05";
}