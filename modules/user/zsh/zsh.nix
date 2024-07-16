{config, lib, pkgs, ...}:

{
  programs.zsh = {
    enableCompletion = true;
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    envExtra = ''
      QT_STYLE_OVERRIDE = kvantum
      QT_QPA_PLATFORM = wayland
      QT_QPA_PLATFORMTHEME = qt6ct
      XDG_SESSION_TYPE = wayland
      XCURSOR_SIZE = 20
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1
      QT_AUTO_SCREEN_SCALE_FACTOR = 1
    '';

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}