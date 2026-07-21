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
			"mz-update" = "~/mz-dotfiles/scripts/mz-update.sh";
			"mz-switch" = "~/mz-dotfiles/scripts/mz-switch.sh";
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
			export ZSH_CUSTOM="$HOME/mz-dotfiles/modules/zsh"
			export VCPKG_ROOT="$HOME/.local/share/vcpkg"
			export SSH="kitty +kitten ssh"
		'';
    };
}
