#! /usr/bin/env bash

function fatal_error() {
    if (( $1 != 0 ))
    then
        echo -e "There was an error while $2. Killing the script... \n"
        exit $1
    fi
}

# Time and date sync
timedatectl set-ntp true

# To avoid dead keys errors at install time
pacman -Sy
pacman -S archlinux-keyring

clear

echo "   ____         __  __  ___  "
echo "  / __/__  ____/ /_/  |/  /__"
echo " _\ \/ _ \/ __/ __/ /|_/ /_ /"
echo "/___/\_, /_/  \__/_/  /_//__/"
echo "      /_/                    "

echo "This installer works once connected to internet and the partition table has been created"
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

echo -e "Timezone (if don't know, stop the script and use "timedatectl list-timezones") [Continent/City]: \c"
read tz

# Partitions formatting and mounting
while true
do
    echo -e "Path to root partition: \c"
    read root

    if [ ! -e $root ]
        then
            echo -e "Invalid partition, try again \n"
            continue
    fi

    echo -e "Format partition? [y/n]"
    read rootf

    case $rootf in
        [Yy] )  echo
                echo -e "The partition will be formatted and mounted \n"
                format_root=1;;

        [Nn] )  echo
                echo -e "The partition will only be mounted \n";;

        * )     echo
                echo -e "Invalid option, try again \n"
                continue;;
    esac

    if [[ $format_root == 1 ]]
    then
        mkfs.ext4 $root
        fatal_error $? "formatting the partition"
    fi

    mount $root /mnt
    fatal_error $? "mounting the partition"

    if [ ! -d "/mnt/boot"]
    then
        mkdir /mnt/boot
        fatal_error $? "creating the /mnt/boot folder"
    fi

    break
done

while true
do
    echo -e "Path to EFI partition: \c"
    read efi

    if [ ! -e $efi ]
        then
            echo -e "Invalid partition, try again \n"
            continue
    fi

    echo -e "Format partition? [y/n]"
    read efif

    case $efif in
        [Yy] )  echo
                echo -e "The partition will be formatted and mounted \n"
                format_efi=1;;

        [Nn] )  echo
                echo -e "The partition will only be mounted \n";;

        * )     echo
                echo -e "Invalid option, try again \n"
                continue;;
    esac

    if [[ $format_efi == 1 ]]
    then
        mkfs.fat -F32 $efi
        fatal_error $? "formatting the partition"

        fatlabel $efi "EFI"
        fatal_error $? "assigning a label to the EFI partition"
    fi

    mount $efi /mnt/boot
    fatal_error $? "mounting the partition"
    
    break
done

while true
do
    echo
    echo "Use SWAP partition? [y/n]"
    read tSw

    case $tSw in
        [Yy] )  echo
                echo -e "Write path of SWAP: \c"
                read swap

                if [ -e $swap ]
                    then
                        echo -e "Invalid partition, try again \n"
                        continue
                fi

                mkswap $swap
                fatal_error $? "formatting the partition"

                swapon $swap -L "SWAP"
                fatal_error $? "mounting the partition"

                break;;
        
        [Nn] )  echo
                echo "No swap partition will be used"
                break;;

        * )     echo
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

pacstrap -K /mnt base base-devel linux-firmware $kernel $kernel-headers mkinitcpio fastfetch curl wget git --noconfirm --needed

# Fstab file generation and chroot
genfstab -U /mnt >> /mnt/etc/fstab

arch-chroot /mnt /bin/bash -e <<EOF

    echo -e "Entered to chroot \n"

    # Set Locale and Language
    sed -i "s/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/" /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" >> /etc/locale.conf

    # Clock and Time Zone
    ln -sf /usr/share/zoneinfo/$tz /etc/localtime
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
    pacman -S neovim networkmanager wireless_tools bluez bluez-utils blueman refind efibootmgr os-prober --noconfirm --needed

    # Enable Services
    systemctl enable NetworkManager
    systemctl enable bluetooth

    # Refind config
    refind-install --usedefault "$efi" --alldrivers
    mkrlconf

    echo '"Boot with minimal options" "ro root=$root"' > /boot/refind_linux.conf

EOF

echo "root:$rPass" | arch-chroot /mnt chpasswd
echo "$user:$uPass" | arch-chroot /mnt chpasswd

umount -R /mnt
fatal_error $? "unmounting the partitions"

echo
echo "Mz's Arch Installer - Process Succeeded"
echo
echo "Type reboot to finish"
