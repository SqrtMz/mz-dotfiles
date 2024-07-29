{ inputs, config, pkgs, ... }:

{
  home.username = "pan";
  home.homeDirectory = "/home/pan";

  imports = [
    ../../modules/user/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
    btop
    fastfetch
    openssh
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
