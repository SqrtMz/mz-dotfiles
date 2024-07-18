{ inputs, config, pkgs, ... }:

{
  home.username = "mz";
  home.homeDirectory = "/home/mz";

  imports = [
    ./modules/user/gtk/gtk.nix
    ./modules/user/hyprland/hyprland.nix
    ./modules/user/kitty/kitty.nix
    ./modules/user/kvantum/kvantum.nix
    ./modules/user/rofi/rofi.nix
    ./modules/user/waybar/waybar.nix
    ./modules/user/wlogout/wlogout.nix
    ./modules/user/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
    btop
    htop
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
