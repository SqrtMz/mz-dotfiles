{ inputs, config, pkgs, ... }:

{
	home.username = "debian";
	home.homeDirectory = "/home/debian";

	nixGL.packages = inputs.nixgl.packages;
	nixGL.defaultWrapper = "mesa";
	nixGL.installScripts = ["mesa"];
	nixGL.vulkan.enable = true;

	imports = [
		../../modules/user/kitty/kitty.nix
		../../modules/user/neovim/neovim.nix
	];

	home.packages = with pkgs; [
		btop
		fastfetch
		pyenv
	];

	# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
	home.stateVersion = "24.05";
	}
