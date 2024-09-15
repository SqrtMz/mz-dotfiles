{config, lib, pkgs, inputs, ...}:

{
    home.username = "mz";
    home.homeDirectory = "/home/mz";

    imports = [
        ../../modules/user/firefox/firefox.nix
        ../../modules/user/hyprland/hyprland.nix
        ../../modules/user/kitty/kitty.nix
        ../../modules/user/rofi/rofi.nix
        ../../modules/user/themes/themes.nix
        ../../modules/user/waybar/waybar.nix
        ../../modules/user/wlogout/wlogout.nix
        ../../modules/user/zsh/zsh.nix
    ];

    home.packages = with pkgs; [
        btop
        fastfetch
        grim
        htop
        neovim
        wl-clipboard
        xournalpp
    ];

    services = {
        cliphist.enable = true;
        gnome-keyring.enable = true;

        flameshot = {
            enable = true;
            package = pkgs.flameshot.override {
                enableWlrSupport = true;
            };

            settings = {  
                General = {
                    disabledTrayIcon = true;
                    uiColor = "#369B99";
                };
            };
        };
    };

    systemd.user.services.startup = {
        Unit = {
            Description = "Startup autorun script";
        };

        Service = {
            ExecStart = "/home/mz/mz-dotfiles/scripts/autorun.sh";
        };

        Install = {
            WantedBy = ["graphical-session.target"];
        };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    home.stateVersion = "24.05";
}
