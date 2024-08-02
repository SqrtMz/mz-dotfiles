{config, lib, pkgs, ...}:

{
  programs.zsh = {
    enableCompletion = true;
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # envExtra = ''
    #   export XDG_CURRENT_DESKTOP=sway
    # '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}