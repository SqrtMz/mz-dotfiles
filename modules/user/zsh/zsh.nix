{config, lib, pkgs, inputs, ...}:

{
	programs.zsh = {
        enable = true;
		package = pkgs.emptyDirectory;
		
    	enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        oh-my-zsh = {
        	enable = true;
        	theme = "robbyrussell";
        };

		shellAliases = {
			"mz-update" = "cd ~/mz-dotfiles && pacman -Qqen > pacman-packages.txt && sudo pacman -Syu --noconfirm && nix flake update && home-manager switch --flake .#mz && cd";
			"mz-switch" = "cd ~/mz-dotfiles && home-manager switch --flake .#mz && cd";
			"mz-news" = "cd ~/mz-dotfiles && home-manager news --flake .#mz && cd";
		};
    };
}