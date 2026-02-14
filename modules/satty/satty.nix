{config, lib, pkgs, inputs, ...}:

{
    programs.satty = {
        enable = true;
        package = pkgs.emptyDirectory;

        settings = {
            general = {
                fullscreen = true;
                early-exit = true;
                copy-command = "wl-copy";
                actions-on-right-click = [];
                actions-on-enter = ["save-to-clipboard" "exit"];
                actions-on-escape = ["exit"];
            };
        };
    };
}