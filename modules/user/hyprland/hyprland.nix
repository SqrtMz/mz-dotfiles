{config, lib, pkgs, inputs, ...}:

{
    home.file.".config/hypr/hyprland.conf".source = ./hyprland.conf;
    
   # wayland.windowManager.hyprland = {
   # 	enable = true;
   #     package = (config.lib.nixGL.wrap pkgs.hyprland);
   #     
   #     xwayland.enable = true;
   #     systemd.enable = true;

   #     extraConfig = ''
   #         exec-once = ~/mz-dotfiles/scripts/autorun.sh            
   # 
   #         ################
   #         ### MONITORS ###
   #         ################

   #         monitor=,preferred,auto,auto

   #         source = ~/mz-dotfiles/modules/user/hyprland/monitors.conf
   #         source = ~/mz-dotfiles/modules/user/hyprland/workspaces.conf

   #         env = XDG_MENU_PREFIX,plasma-

   #         ###################
   #         ### MY PROGRAMS ###
   #         ###################

   #         $terminal = kitty
   #         $fileManager = dolphin
   #         $menu = rofi -show drun

   #         #####################
   #         ### LOOK AND FEEL ###
   #         #####################

   #         general { 
   #             gaps_in = 5
   #             gaps_out = 10

   #             border_size = 2

   #             # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
   #             col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
   #             col.inactive_border = rgba(595959aa)

   #             # Set to true enable resizing windows by clicking and dragging on borders and gaps
   #             resize_on_border = false 

   #             # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
   #             allow_tearing = false

   #             layout = dwindle
   #         }

   #         # https://wiki.hyprland.org/Configuring/Variables/#decoration
   #         decoration {
   #             rounding = 10

   #             # Change transparency of focused and unfocused windows
   #             active_opacity = 1.0
   #             inactive_opacity = 1.0

   #             drop_shadow = true
   #             shadow_range = 4
   #             shadow_render_power = 3
   #             col.shadow = rgba(1a1a1aee)

   #             # https://wiki.hyprland.org/Configuring/Variables/#blur
   #             blur {
   #                 enabled = true
   #                 size = 3
   #                 passes = 1
   #                 
   #                 vibrancy = 0.1696
   #             }
   #         }

   #         # https://wiki.hyprland.org/Configuring/Variables/#animations
   #         animations {
   #             enabled = true

   #             # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

   #             bezier = myBezier, 0.05, 0.9, 0.1, 1.05

   #             animation = windows, 1, 7, myBezier
   #             animation = windowsOut, 1, 7, default, popin 80%
   #             animation = border, 1, 10, default
   #             animation = borderangle, 1, 8, default
   #             animation = fade, 1, 7, default
   #             animation = workspaces, 1, 6, default
   #         }

   #         # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
   #         dwindle {
   #             pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
   #             preserve_split = true # You probably want this
   #         }

   #         # https://wiki.hyprland.org/Configuring/Variables/#misc
   #         misc { 
   #             force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
   #             disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
   #         }


   #         #############
   #         ### INPUT ###
   #         #############

   #         input {
   #             kb_layout = us
   #             kb_variant = altgr-intl
   #             kb_model =
   #             kb_options =
   #             kb_rules =

   #             follow_mouse = 1

   #             sensitivity = 0
   #             accel_profile = flat

   #             touchpad {
   #                 natural_scroll = false
   #             }
   #         }

   #         gestures {
   #             workspace_swipe = false
   #         }

   #         ####################
   #         ### KEYBINDINGSS ###
   #         ####################

   #         $mainMod = SUPER

   #         bind = $mainMod, Q, exec, $terminal
   #         bind = $mainMod, Escape, killactive,
   #         bind = $mainMod, M, exit,
   #         bind = $mainMod, E, exec, $fileManager
   #         bind = $mainMod, W, exec, $menu
   #         bind = $mainMod, P, pseudo
   #         bind = $mainMod, J, togglesplit
   #         bind = $mainMod, F, fullscreen,
   #         bind = $mainMod SHIFT, F, togglefloating

   #         bind = $mainMod, Print, exec, flameshot gui --raw | wl-copy
   #         bind = , Print, exec, grim -g "$(slurp)" - | wl-copy

   #         bindl = , XF86AudioPlay, exec, playerctl play-pause

   #         # Move focus with mainMod + arrow keys
   #         bind = $mainMod, left, movefocus, l
   #         bind = $mainMod, right, movefocus, r
   #         bind = $mainMod, up, movefocus, u
   #         bind = $mainMod, down, movefocus, d

   #         # Switch workspaces with mainMod + [0-9]
   #         bind = $mainMod, 1, workspace, 1
   #         bind = $mainMod, 2, workspace, 2
   #         bind = $mainMod, 3, workspace, 3
   #         bind = $mainMod, 4, workspace, 4
   #         bind = $mainMod, 5, workspace, 5
   #         bind = $mainMod, 6, workspace, 6
   #         bind = $mainMod, 7, workspace, 7
   #         bind = $mainMod, 8, workspace, 8
   #         bind = $mainMod, 9, workspace, 9
   #         bind = $mainMod, 0, workspace, 10

   #         bind = ALT, Tab, workspace, e+1
   #         bind = SHIFT ALT, Tab, workspace, e-1

   #         # Move active window to a workspace with mainMod + SHIFT + [0-9]
   #         bind = $mainMod SHIFT, 1, movetoworkspace, 1
   #         bind = $mainMod SHIFT, 2, movetoworkspace, 2
   #         bind = $mainMod SHIFT, 3, movetoworkspace, 3
   #         bind = $mainMod SHIFT, 4, movetoworkspace, 4
   #         bind = $mainMod SHIFT, 5, movetoworkspace, 5
   #         bind = $mainMod SHIFT, 6, movetoworkspace, 6
   #         bind = $mainMod SHIFT, 7, movetoworkspace, 7
   #         bind = $mainMod SHIFT, 8, movetoworkspace, 8
   #         bind = $mainMod SHIFT, 9, movetoworkspace, 9
   #         bind = $mainMod SHIFT, 0, movetoworkspace, 10

   #         # Example special workspace (scratchpad)
   #         bind = $mainMod, S, togglespecialworkspace, magic
   #         bind = $mainMod SHIFT, S, movetoworkspace, special:magic

   #         # Scroll through existing workspaces with mainMod + scroll
   #         bind = $mainMod, mouse_down, workspace, e+1
   #         bind = $mainMod, mouse_up, workspace, e-1

   #         # Move/resize windows with mainMod + LMB/RMB and dragging
   #         bindm = $mainMod, mouse:272, movewindow
   #         bindm = $mainMod, mouse:273, resizewindow

   #         # Cliphist Binds
   #         bind = SUPER, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy


   #         ##############################
   #         ### WINDOWS AND WORKSPACES ###
   #         ##############################

   #         windowrule = float, ^(unityhub)$
   #         windowrule = float, ^(nm-connection-editor)$
   #         windowrule = float, ^(org.kde.ark)$

   #         windowrulev2 = suppressevent maximize, class:.*

   #         windowrulev2 = float, title:(Picture-in-Picture)
   #         windowrulev2 = float, class:(firefox), title:(Library)

   #         windowrulev2 = float, class:(SDL Application), title:.*
   #         windowrulev2 = float, class:(python3), title:.*
   #         windowrulev2 = float, class:(pavucontrol)

   #         windowrulev2 = float, class:(kitty), title:(btop)
   #         windowrulev2 = center, class:(kitty), title:(btop)
   #         '';
   # };
}
