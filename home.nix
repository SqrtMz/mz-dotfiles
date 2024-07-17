{ inputs, config, pkgs, ... }:

{
  home.username = "mz";
  home.homeDirectory = "/home/mz";

  imports = [
    ./modules/user/hyprland/hyprland.nix
    ./modules/user/kitty/kitty.nix
    ./modules/user/wlogout/wlogout.nix
    ./modules/user/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
    btop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
