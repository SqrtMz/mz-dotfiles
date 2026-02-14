{config, lib, pkgs, inputs, ...}:

{
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

            exec-once = [
                "~/mz-dotfiles/scripts/autorun.sh"
            ];

            source = [
                "~/mz-dotfiles/modules/hyprland/monitors.conf"
                "~/mz-dotfiles/modules/hyprland/workspaces.conf"
            ];

            env = [
                # Fix dolphin open with
                #"XDG_MENU_PREFIX,plasma-"
                #"QT_QPA_PLATFORM,wayland"

                # Make electron programs use wayland instead of xwayland
                "ELECTRON_OZONE_PLATFORM_HINT,auto"

                # Use Arch QT packages instead of Nix ones
                # "QT_PLUGIN_PATH,/usr/lib/qt6/plugins"
                # "QML2_IMPORT_PATH,/usr/lib/qt6/qml"

                "MANGOHUD,1"
            ];

            general = {
                gaps_in = 5;
                gaps_out = 5;
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

            input = {
                kb_layout = "us";
                kb_variant = "altgr-intl";

                follow_mouse = 1;
                sensitivity = 0;
                accel_profile = "flat";

                touchpad = {
                    natural_scroll = false;
                };
            };

            bind = [
                # General keybinds
                "$mainMod, Q, exec, $terminal"
                "$mainMod, Escape, killactive,"
                "$mainMod, M, exit,"
                "$mainMod, E, exec, $fileManager"
                "$mainMod, W, exec, $menu"
                "$mainMod, P, pseudo"
                "$mainMod, J, togglesplit"
                "$mainMod, F, fullscreen,"
                "$mainMod SHIFT, F, togglefloating"

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

                # Screenshots
                ", Print, exec, flameshot gui | wl-copy"
                "SHIFT, Print, exec, grim -g \"$(slurp)\" - | satty -f -"

                # Move focus with mainMod + arrow keys
                "$mainMod, left, movefocus, l"
                "$mainMod, right, movefocus, r"
                "$mainMod, up, movefocus, u"
                "$mainMod, down, movefocus, d"

                # Alt Tab workspace switching
                "ALT, Tab, workspace, e+1"
                "SHIFT ALT, Tab, workspace, e-1"

                # Mouse scroll workspace switching
                "$mainMod, mouse_down, workspace, e+1"
                "$mainMod, mouse_up, workspace, e-1"

                # Special workspace
                "$mainMod, S, togglespecialworkspace, magic"
                "$mainMod SHIFT, S, movetoworkspace, special:magic"

                # Cliphist clipboard
                "SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
            ];

            bindl = [
                # Media keys - Nonrepeatable
                ", XF86AudioNext, exec, playerctl next"
                ", XF86AudioPause, exec, playerctl play-pause"
                ", XF86AudioPlay, exec, playerctl play-pause"
                ", XF86AudioPrev, exec, playerctl previous"
            ];

            bindel = [
                # Media keys - Repeatable
                ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                #", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                #", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
                ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
            ];

            bindm = [
                # Move/resize windows with mainMod + LMB/RMB and dragging
                "$mainMod, mouse:272, movewindow"
                "$mainMod, mouse:273, resizewindow"
            ];
        };

        extraConfig = ''
            #####################
            ### LOOK AND FEEL ###
            #####################

            animations {
                enabled = true
                bezier = myBezier, 0.05, 0.9, 0.1, 1.05
                animation = windows, 1, 7, myBezier
                animation = windowsOut, 1, 7, default, popin 80%
                animation = border, 1, 10, default
                animation = borderangle, 1, 8, default
                animation = fade, 1, 7, default
                animation = workspaces, 1, 6, default
            }

            ##############################
            ### WINDOWS AND WORKSPACES ###
            ##############################

            windowrule {
                name = NetworkManager Connection Editor
                match:class = nm-connection-editor
                float = true
            }

            windowrule {
                name = Ark
                match:class = org.kde.ark
                float = true
            }

            # Firefox - Make floating windows
            windowrule {
                name = Firefox Picture-in-Picture
                match:title = Picture-in-Picture
                float = true
            }
            
            windowrule {
                name = Firefox Library
                match:class = firefox
                match:title = Library
                float = true
            }

            # Steam - Make floating windows
            windowrule {
                name = Steam Settings
                match:class = steam
                match:title = Steam Settings
                float = true
            }

            windowrule {
                name = Steam Friends List
                match:class = steam
                match:title = Friends List
                float = true
            }

			# # Intellij - tab dragging fix
			# windowrulev2 = float, class:^(jetbrains-.*),title:^(win.*)
			# windowrulev2 = noinitialfocus, opacity 0.9 0.9, class:^(jetbrains-.*)

            windowrule {
                name = PulseAudio Volume Control
                match:class = org.pulseaudio.pavucontrol
                match:title = .*
                float = true
            }
            
            windowrule {
                name = File Pickers
                match:class = xdg-desktop-portal-gtk
                match:title = .*
                float = true
            }

			# Avoid some windowed programs taking over all the workspace (fullscreen like) even when there's another windows
            windowrule {
                name = Supress Maximize Events
                match:class = .*
                suppress_event = maximize
            }

            windowrule {
                name = XWayland Dragging Fix
                match:class = ^$
                match:title = ^$
                match:xwayland = true
                match:float = true
                match:fullscreen = false
                match:pin = false
                no_focus = true
            }
        '';
   };
}
