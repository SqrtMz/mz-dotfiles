{config, lib, pkgs, inputs, ...}:

{
    programs.kitty = {
        enable = true;
        package = pkgs.emptyDirectory;
        
        shellIntegration = {
            enableZshIntegration = true;
            mode = "enable";
        };

        settings = {
            enable_audio_bell = false;
            cursor_shape = "beam";
        };

        extraConfig = ''
            background_opacity 0.6

            # Black
            color0 #45475A
            color8 #585B70
            
            # Red
            color1 #F38BA8
            color9 #F38BA8

            # Green
            color2  #A6E3A1
            color10 #A6E3A1
            
            # Yellow
            color3  #F9E2AF
            color11 #F9E2AF
            
            # Blue
            color4  #89B4FA
            color12 #89B4FA

            # Magenta
            color5  #F5C2E7
            color13 #F5C2E7

            # Cyan
            color6  #94E2D5
            color14 #94E2D5

            # White
            color7  #BAC2DE
            color15 #A6ADC8
        '';

    };
}