{ inputs, config, pkgs, ... }:

{
  home.username = "nix-on-droid";
  home.homeDirectory = "/home/nix-on-droid";

  imports = [
    ../../modules/user/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
