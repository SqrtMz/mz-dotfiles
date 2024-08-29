{config, lib, pkgs, inputs, ...}:

{
	programs.zsh = {
    	enableCompletion = true;
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
        	enable = true;
        	theme = "robbyrussell";
        };

		shellAliases = {
			Mz = "sudo nixos-rebuild switch --flake ~/mz-dotfiles#Mz";
			update = "nix flake update ./mz-dotfiles";
		};
    };
}