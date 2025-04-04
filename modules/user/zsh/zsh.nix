{config, lib, pkgs, inputs, ...}:

{
	programs.zsh = {
    	enableCompletion = true;
        enable = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
		package = pkgs.emptyDirectory;

        oh-my-zsh = {
        	enable = true;
        	theme = "robbyrussell";
        };

		shellAliases = {
			"mzup" = "cd ~/mz-dotfiles && sudo pacman -Syu --noconfirm && nix flake update && home-manager switch --flake .#mz && cd";
			"mzsw" = "cd ~/mz-dotfiles && home-manager switch --flake .#mz && cd";
			"mz-news" = "cd ~/mz-dotfiles && home-manager news --flake .#mz && cd";
		};
    };
}
