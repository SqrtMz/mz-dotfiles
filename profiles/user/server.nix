{ inputs, config, pkgs, ... }:

{
  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";

  imports = [
  ];

  home.packages = with pkgs; [
    btop
    fastfetch
    neovim
    pyenv
    virtualenv
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
