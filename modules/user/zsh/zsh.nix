{config, lib, pkgs, ...}:

{
  programs.zsh = {
    enableCompletion = true;
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      export QT_STYLE_OVERRIDE=kvantum
      export QT_QPA_PLATFORM=wayland
      export QT_QPA_PLATFORMTHEME=qt6ct
      export XDG_SESSION_TYPE=wayland
      export XCURSOR_SIZE=20
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export QT_AUTO_SCREEN_SCALE_FACTOR=1
    '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}