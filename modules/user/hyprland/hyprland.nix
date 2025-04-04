{config, lib, pkgs, inputs, ...}:

{
    # home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    
    wayland.windowManager.hyprland = {
   	    enable = true;
        package = null;
       
        xwayland.enable = true;

        systemd = {
            enable = true;
            variables = [ "--all" ];
        };

        settings = {
            "$terminal" = "kitty";
            "$fileManager" = "dolphin";
            "$menu" = "rofi -show drun";
            "$mainMod" = "SUPER";

            general = {
                gaps_in = 5;
                gaps_out = 10;
                border_size = 2;

                "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
                "col.inactive_border" = "rgba(595959aa)";

                resize_on_border = false;
                allow_tearing = false;
                layout = "dwindle";
            };

            decoration = {
                rounding = 10;
                active_opacity = 1.0;
                inactive_opacity = 1.0;


                shadow = {
                    enabled = true;
                    range = 4;
                    render_power = 3;
                    color = "rgba(1a1a1aee)";
                };

                blur = {
                    enabled = true;
                    size = 3;
                    passes = 1;
                    vibrancy = 0.1696;
                };
            };

            bind = [
                # Hyprsome binds
                "$mainMod, 1, exec, hyprsome workspace 1"
                "$mainMod, 2, exec, hyprsome workspace 2"
                "$mainMod, 3, exec, hyprsome workspace 3"
                "$mainMod, 4, exec, hyprsome workspace 4"
                "$mainMod, 5, exec, hyprsome workspace 5"
                "$mainMod, 6, exec, hyprsome workspace 6"
                "$mainMod, 7, exec, hyprsome workspace 7"
                "$mainMod, 8, exec, hyprsome workspace 8"
                "$mainMod, 9, exec, hyprsome workspace 9"
                "$mainMod, 0, exec, hyprsome workspace 10"
                
                "$mainMod SHIFT, 1, exec, hyprsome movefocus 1"
                "$mainMod SHIFT, 2, exec, hyprsome movefocus 2"
                "$mainMod SHIFT, 3, exec, hyprsome movefocus 3"
                "$mainMod SHIFT, 4, exec, hyprsome movefocus 4"
                "$mainMod SHIFT, 5, exec, hyprsome movefocus 5"
                "$mainMod SHIFT, 6, exec, hyprsome movefocus 6"
                "$mainMod SHIFT, 7, exec, hyprsome movefocus 7"
                "$mainMod SHIFT, 8, exec, hyprsome movefocus 8"
                "$mainMod SHIFT, 9, exec, hyprsome movefocus 9"
                "$mainMod SHIFT, 0, exec, hyprsome movefocus 10"
            ];
        };

        extraConfig = ''
            exec-once = ~/mz-dotfiles/scripts/autorun.sh

            ################
            ### MONITORS ###
            ################

            source = ~/mz-dotfiles/modules/user/hyprland/monitors.conf
            source = ~/mz-dotfiles/modules/user/hyprland/workspaces.conf

            # Fix dolphin open with
            env = XDG_MENU_PREFIX,plasma-
            env = QT_QPA_PLATFORM,wayland

            # Use Arch QT packages instead of Nix ones
            env = QT_PLUGIN_PATH,/usr/lib/qt6/plugins
            env = QML2_IMPORT_PATH,/usr/lib/qt6/qml

            env = MANGOHUD,1

            #####################
            ### LOOK AND FEEL ###
            #####################

            # https://wiki.hyprland.org/Configuring/Variables/#colors
            animations {
                enabled = true

                # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

                bezier = myBezier, 0.05, 0.9, 0.1, 1.05

                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
            dwindle {
                pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true # You probably want this
            }

            # https://wiki.hyprland.org/Configuring/Variables/#misc
            misc { 
                force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
                disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
            }


            #############
            ### INPUT ###
            #############

            input {
                kb_layout = us
                kb_variant = altgr-intl
                kb_model =
                kb_options =
                kb_rules =

                follow_mouse = 1

                sensitivity = 0
                accel_profile = flat

                touchpad {
                    natural_scroll = false
                }
            }

            gestures {
                workspace_swipe = false
            }

            ####################
            ### KEYBINDINGSS ###
            ####################

            bind = $mainMod, Q, exec, $terminal
            bind = $mainMod, Escape, killactive,
            bind = $mainMod, M, exit,
            bind = $mainMod, E, exec, $fileManager
            bind = $mainMod, W, exec, $menu
            bind = $mainMod, P, pseudo
            bind = $mainMod, J, togglesplit
            bind = $mainMod, F, fullscreen,
            bind = $mainMod SHIFT, F, togglefloating

            bind = , Print, exec, flameshot gui --raw | wl-copy
            bind = SHIFT, Print, exec, grim -g "$(slurp)" - | wl-copy

            bindel = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
            bindel = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            # bindel = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            # bindel = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
            bindel = , XF86MonBrightnessUp, exec, brightnessctl s 10%+
            bindel = , XF86MonBrightnessDown, exec, brightnessctl s 10%-

            bindl = , XF86AudioNext, exec, playerctl next
            bindl = , XF86AudioPause, exec, playerctl play-pause
            bindl = , XF86AudioPlay, exec, playerctl play-pause
            bindl = , XF86AudioPrev, exec, playerctl previous

            # Move focus with mainMod + arrow keys
            bind = $mainMod, left, movefocus, l
            bind = $mainMod, right, movefocus, r
            bind = $mainMod, up, movefocus, u
            bind = $mainMod, down, movefocus, d

            bind = ALT, Tab, workspace, e+1
            bind = SHIFT ALT, Tab, workspace, e-1

            # Example special workspace (scratchpad)
            bind = $mainMod, S, togglespecialworkspace, magic
            bind = $mainMod SHIFT, S, movetoworkspace, special:magic

            # Scroll through existing workspaces with mainMod + scroll
            bind = $mainMod, mouse_down, workspace, e+1
            bind = $mainMod, mouse_up, workspace, e-1

            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow

            # Cliphist Binds
            bind = SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy

            ##############################
            ### WINDOWS AND WORKSPACES ###
            ##############################

            windowrulev2 = float, class:(nm-connection-editor)
            windowrulev2 = float, class:(org.kde.ark)

            # Firefox
            windowrulev2 = float, title:(Picture-in-Picture)
            windowrulev2 = float, class:(firefox), title:(Library)

            # Steam
            windowrulev2 = float, class:(steam), title:(Steam Settings)
            windowrulev2 = float, class:(steam), title:(Friends List)

            windowrulev2 = float, class:(org.pulseaudio.pavucontrol), title:.*

            windowrulev2 = suppressevent maximize, class:.*

            # Fix some dragging issues with XWayland
            windowrulev2 = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
           '';
   };
}
