{ inputs, config, pkgs, ... }:

{
  imports = [
    ../../modules/user/zsh/zsh.nix
  ];

  home.packages = with pkgs; [
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.stateVersion = "24.05";
}
