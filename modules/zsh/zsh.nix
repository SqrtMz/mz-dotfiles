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
        	theme = "mz";
        };

		shellAliases = {
			"mz-update" = "cd ~/mz-dotfiles && pacman -Qqe > pacman-packages.txt && paru -Syu --noconfirm && nix flake update && home-manager switch --flake .#mz && cd";
			"mz-switch" = "cd ~/mz-dotfiles && pacman -Qqe > pacman-packages.txt && home-manager switch --flake .#mz && cd";
			"mz-news" = "cd ~/mz-dotfiles && home-manager news --flake .#mz && cd";
			"mz-delete-unused" = "pacman -Qtdq | xargs sudo pacman -Rns --noconfirm";
			"ff" = "fastfetch";
		};

		envExtra = ''
			export QT_QPA_PLATFORMTHEME="qt6ct"
			export ELECTRON_OZONE_PLATFORM_HINT="auto"
			export MANGOHUD="1"
			export ROCM_PATH="/opt/rocm"
			export HSA_OVERRIDE_GFX_VERSION="10.3.0"
			export ZSH_CUSTOM="/home/mz/mz-dotfiles/modules/zsh"
		'';
    };
}