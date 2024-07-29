{ inputs, config, pkgs, ... }:

{
  home.username = "debian";
  home.homeDirectory = "/home/debian";

  imports = [
    ../../modules/user/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
    fastfetch
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
