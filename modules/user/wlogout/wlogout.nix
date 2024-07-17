{config, lib, pkgs, ...}:

{
    programs.wlogout = {
        enable = true;

        layout = [
            {
                label = "lock";
                action = "loginctl lock-session";
                text = "Lock";
                keybind = "l";
            }
            {
                label = "hibernate";
                action = "systemctl hibernate";
                text = "Hibernate";
                keybind = "h";
            }
            {
                label = "logout";
                action = "loginctl terminate-user $USER";
                text = "Logout";
                keybind = "e";
            }
            {
                label = "shutdown";
                action = "systemctl poweroff";
                text = "Shutdown";
                keybind = "s";
            }
            {
                label = "suspend";
                action = "systemctl suspend";
                text = "Suspend";
                keybind = "u"
            }
            {
                label = "reboot";
                action = "systemctl reboot";
                text = "Reboot";
                keybind = "r";
            }
        ];

        style = ''
            * {
                background-image: none;
                box-shadow: none;
            }

            window {
                background-color: rgba(12, 12, 12, 0.9);
            }

            button {
                border-radius: 0;
                border-color: black;
                text-decoration-color: #FFFFFF;
                color: #FFFFFF;
                background-color: #1E1E1E;
                border-style: solid;
                border-width: 1px;
                background-repeat: no-repeat;
                background-position: center;
                background-size: 25%;
            }

            button:focus, button:active, button:hover {
                background-color: #009090;
                outline-style: none;
            }

            #lock {
                background-image: image(url("/home/mz/.nix-profile/share/wlogout/icons/lock.png"));
            }

            #logout {
                background-image: image(url("/home/mz/.nix-profile/share/wlogout/icons/logout.png"));
            }

            #suspend {
                background-image: image(url("/home/mz/.nix-profile/share/wlogout/icons/suspend.png"));
            }

            #hibernate {
                background-image: image(url("/home/mz/.nix-profile/share/wlogout/icons/hibernate.png"));
            }

            #shutdown {
                background-image: image(url("/home/mz/.nix-profile/share/wlogout/icons/shutdown.png"));
            }

            #reboot {
                background-image: image(url("/home/mz/.nix-profile/share/wlogout/icons/reboot.png"));
            }
        '';
    };
}