#! /usr/bin/env bash

# Time and date sync
timedatectl set-ntp true

clear

echo "   ____         __  __  ___  "
echo "  / __/__  ____/ /_/  |/  /__"
echo " _\ \/ _ \/ __/ __/ /|_/ /_ /"
echo "/___/\_, /_/  \__/_/  /_//__/"
echo "      /_/                    "

echo "This installer works once connected to internet and created the partition table"
echo

# User Configurations
echo -e "Hostname: \c"
read hostname

echo -e "User: \c"
read user

echo -e "Root user password: \c"
read rPass

echo -e "User password: \c"
read uPass

# Partitions formatting and mounting
while true
do
    echo -e "Path to main partition: \c"
    read main

    mkfs.ext4 $main

    if (($? == 1))
    then
        echo -e "Invalid partition, try again \n"
        continue
    fi

    mount $main /mnt
    mkdir /mnt/boot

    break
done

while true
do
    echo -e "Path to EFI partition: \c"
    read efi

    mkfs.fat -F32 $efi

    if (($? == 1))
    then
        echo -e "Invalid partition, try again \n"
        continue
    fi

    mount $efi /mnt/boot
    
    break
done

while true
do
    echo
    echo "Use SWAP partition? [y/n]"
    read tSw

    case $tSw in
        [Yy]* ) echo
                echo -e "Write path of SWAP: \c"
                read swap

                mkswap $swap

                if (($? == 1))
                then
                    echo
                    echo -e "Invalid partition, try again \n"
                    continue
                fi

                swapon $swap

                break;;
        
        [Nn]* ) echo
                echo "No swap partition will be used"
                break;;

        * ) echo
            echo "Invalid option, try again"
            continue;;
    esac
done

# Pacman Keyring and Pacstrap
pacman-key --init
pacman-key --populate archlinux

while true
do
    echo
    echo "Select Linux kernel"
    echo "1. Stable"
    echo "2. Zen"
    read kSel

    case $kSel in
        1 ) echo -e "Stable"
            kernel="linux"
            break;;
        
        2 ) echo "Zen"
            kernel="linux-zen"
            break;;

        * ) echo "Invalid option, try again"
            continue;;
    esac
done

pacstrap -i /mnt base base-devel linux-firmware $kernel $kernel-headers mkinitcpio fastfetch curl wget git --noconfirm --needed

# Fstab file generation and chroot
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash -e <<EOF

    echo "Entered to chroot"

    # Set Locale and Language
    sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf

    # Clock and Time Zone
    ln -sf /usr/share/zoneinfo/America/Bogota /etc/localtime
    hwclock -w

    # Hostname and hosts
    echo "$hostname" > /etc/hostname

    echo "127.0.0.1   localhost" > /etc/hosts
    echo "::1         localhost" >> /etc/hosts
    echo "127.0.1.1   $hostname.localdomain   $hostname" >> /etc/hosts

    # Add user and sudoers file
    useradd -m -g users -G wheel -s /bin/bash $user

    sed -i "s/^root ALL=(ALL:ALL) ALL/root ALL=(ALL:ALL) ALL\n$user ALL=(ALL:ALL) ALL/" /etc/sudoers

    # Pacman Config File
    sed -i "s|^#Color|Color|" /etc/pacman.conf
    sed -i "s|^#VerbosePkgLists|VerbosePkgLists|" /etc/pacman.conf
    sed -i "s|^#ParallelDownloads = 5|ParallelDownloads = 5\nILoveCandy|" /etc/pacman.conf

    sed -i "s|^#\\[multilib\\]|\\[multilib\\]|" /etc/pacman.conf
    sed -i "/^\\[multilib\\]/,/#Include = \\/etc\\/pacman.d\\/mirrorlist/ s|#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|" /etc/pacman.conf

    pacman -Syu --noconfirm --needed

    # Install Fundamentals
    pacman -S neovim networkmanager wireless_tools refind efibootmgr os-prober --noconfirm --needed

    # Enable Services
    systemctl enable NetworkManager
    systemctl enable bluetooth

    # Refind config
    refind-install --usedefault "$efi" --alldrivers
    mkrlconf

    echo '"Boot with minimal options"   "ro root=$main"' > /boot/refind_linux.conf

EOF

echo "root:$rPass" | arch-chroot /mnt chpasswd
echo "$user:$uPass" | arch-chroot /mnt chpasswd

umount -R /mnt

echo
echo "Mz's Arch Installer - Process Succeeded"
echo
echo "Type reboot to finish"