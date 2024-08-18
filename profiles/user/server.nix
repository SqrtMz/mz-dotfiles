{ inputs, config, pkgs, ... }:

{
  home.username = "debian";
  home.homeDirectory = "/home/debian";

  imports = [
  ];

  home.packages = with pkgs; [
    btop
    bzip2
    fastfetch
    libffi
    ncurses
    neovim
    openssl
    pyenv
    readline
    virtualenv
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
