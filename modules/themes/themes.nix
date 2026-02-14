{config, lib, pkgs, inputs, ...}:

{
    home.pointerCursor = {
        name = "Bibata-Original-Classic";
        size = 20;
        package = pkgs.bibata-cursors;
        gtk.enable = true;
    };

    stylix = {
		enable = true;
		polarity = "dark";
		base16Scheme = ./catppuccin-mocha.yaml;

		fonts = {
			serif = {
				name = "NotoSerif Nerd Font Regular";
			};

			sansSerif = {
				name = "NotoSans Nerd Font Regular";
			};

			monospace = {
				name = "NotoSansM Nerd Font Mono Regular";
			};

			emoji = {
				package = pkgs.noto-fonts-color-emoji;
				name = "Noto Color Emoji";
			};

			sizes = {
				applications = 10;
				desktop = 10;
			};
		};

		icons = {
			enable = true;
			dark = "WhiteSur-dark";
			package = pkgs.whitesur-icon-theme;
		};

		targets = {
			gtk.enable = true;
			hyprland.enable = false;
			rofi.enable = false;
			waybar.enable = false;

			qt = {
				enable = true;
				standardDialogs = "gtk3";
			};

			firefox = {
				profileNames = ["Mz"];
				fonts.enable = false;
			};

			kitty = {
				enable = false;
				variant256Colors = true;
			};
		};
	};
}