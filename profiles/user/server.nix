{ inputs, config, pkgs, ... }:

{
  home.username = "debian";
  home.homeDirectory = "/home/debian";

  imports = [
  ];

  home.packages = with pkgs; [
    btop
    fastfetch
    pyenv
    virtualenv
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
