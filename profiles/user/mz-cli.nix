{ inputs, config, pkgs, ... }:

{
  home.username = "";
  home.homeDirectory = "/home/";

  imports = [
    ../../modules/user/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
    btop
    fastfetch
    git
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
