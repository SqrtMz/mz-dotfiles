#! /bin/bash

timedatectl set-ntp true

clear

echo "Mz's graphic's installer"
echo "This script works once connected to internet"

# Pipewire install
echo
echo "Installing Pipewire"

sudo pacman -S pipewire pipewire-audio gst-plugin-pipewire pipewire-alsa pipewire-jack pipewire-pulse pipewire-roc realtime-privileges --noconfirm --needed

# Graphic drivers install

while true
do
    echo
    echo "Install AMDGPU drivers? [y/n]"
    read tAMD

    echo

    case $tAMD in
        [Yy]* ) echo "Installing AMDGPU drivers"
                sudo pacman -S xf86-video-amdgpu lib32-vulkan-radeon vulkan-tools lib32-libva-mesa-driver mesa-vdpau vdpauinfo clinfo --noconfirm --needed
                break;;
        
        [Nn]* ) echo "AMDGPU drivers won't be installed"
                break;;

        * ) echo "Invalid option, try again"
            continue;;
    esac
done

while true
do
    echo
    echo "Install Intel drivers? [y/n]"
    read tIntel

    echo

    case $tIntel in
        [Yy]* ) echo "Installing Intel drivers"
                sudo pacman -S xf86-video-intel lib32-vulkan-intel vulkan-tools lib32-mesa intel-media-driver libva-utils libva-intel-driver intel-compute-runtime vdpauinfo clinfo --noconfirm --needed
                break;;
        
        [Nn]* ) echo "Intel drivers won't be installed"
                break;;

        * ) echo "Invalid option, try again"
            continue;;
    esac
done

while true
do
    echo
    echo "Install NVIDIA drivers? [y/n]"
    read tNV

    echo

    case $tNV in
        [Yy]* ) echo "Installing AMDGPU drivers"
                sudo pacman -S xf86-video-nouveau --noconfirm --needed
                break;;
        
        [Nn]* ) echo "NVIDIA drivers won't be installed"
                break;;

        * ) echo "Invalid option, try again"
            continue;;
    esac
done

while true
do
    echo
    echo "Select a desktop"
    echo "1. HyprlandWM"
    echo "2. SwayWM"
    echo "3. KDE Plasma"
    read dSel

    echo

    case $dSel in
        1 ) echo "HyprlandWM Selected"
            desktop="hyprland"
            break;;
        
        2 ) echo "SwayWM Selected"
            desktop="sway"
            break;;

        3 ) echo "KDE Plasma Selected"
            desktop="plasma"

        * ) echo "Invalid option, try again"
            continue;;
    esac
done

if ((desktop == "hyprland"))
then
    sudo pacman -S hyprland brightnessctl pavucontrol waybar rofi-wayland cliphist sddm ranger ttf-nerd-fonts-symbols ttf-font-awesome breeze breeze-gtk gnome-keyring wev nwg-look qt6ct grim slurp xdg-desktop-portal-hyprland archlinux-xdg-menu polkit-gnome hyprpaper network-manager-applet kvantum --noconfirm --needed
    sudo ln -s /etc/xdg/menus/arch-applications.menu /etc/xdg/menus/applications.menu

elif ((desktop == "sway"))
then

    sudo pacman -S sway swaybg brightnessctl pavucontrol waybar rofi-wayland cliphist sddm ranger ttf-nerd-fonts-symbols ttf-font-awesome breeze breeze-gtk gnome-keyring wev nwg-look qt6ct grim slurp xdg-desktop-portal xdg-desktop-portal-wlr archlinux-xdg-menu polkit-gnome network-manager-applet kvantum --noconfirm --needed
    sudo ln -s /etc/xdg/menus/arch-applications.menu /etc/xdg/menus/applications.menu
    
elif ((desktop == "plasma"))
then

    sudo pacman -S plasma

fi


# Installing basics
sudo pacman -S xorg dolphin kitty firefox ark okular libreoffice-still ntfs-3g gparted btop nvtop cmake gthumb krita steam mangohud goverlay zsh clonezilla ncdu discord blender kdeconnect sshfs stow obs-studio virtualbox arch-install-scripts poppler-glib pyenv python-virtualenv --noconfirm --needed

sudo gpasswd -a $USER vboxusers
sudo systemctl enable sddm

echo
echo "Process Complete"