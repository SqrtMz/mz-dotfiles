{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "mz";
  home.homeDirectory = "/home/mz";

  imports = [
    ./modules/user/zsh/zsh.nix
    ./modules/user/kitty/kitty.nix
    ./modules/user/hyprland/hyprland.nix
    ./modules/user/wlogout/wlogout.nix
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    btop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
