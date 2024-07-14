#! /bin/bash

# Time and date sync
timedatectl set-ntp true

clear

echo "Mz's Arch Installer"
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

pacstrap -i /mnt base base-devel neovim linux-firmware $kernel $kernel-headers mkinitcpio fastfetch curl wget git --noconfirm --needed

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
    # sed -i "s/^#color/color" /etc/pacman.conf
    # sed -i "s/^#VerbosePkgLists/VerbosePkgLists" /etc/pacman.conf
    # sed -i "s/^#ParallelDownloads = 5/ParallelDownloads = 5\nILoveCandy" /etc/pacman.conf
    sed -i "s/^#\\[multilib\\]/\\[multilib\\]/" /etc/pacman.conf
    sed -i "s|^#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|" /etc/pacman.conf
    pacman -Syu --noconfirm --needed

    # Install Fundamentals
    pacman -S networkmanager wireless_tools grub efibootmgr os-prober xdg-user-dirs --noconfirm --needed

    # Enable Services
    systemctl enable NetworkManager

    # Create File tree on root and user
    xdg-user-dirs-update
    su $user -c "xdg-user-dirs-update"

    # Grub config
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=$user
    grub-install --target=x86_64-efi --efi-directory=/boot --removable

    echo "" >> /etc/default/grub
    echo "# Last selected OS" >> /etc/default/grub
    echo "GRUB_SAVEDEFAULT=true" >> /etc/default/grub

    sed -i "s/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub

    grub-mkconfig -o /boot/grub/grub.cfg

EOF

echo "root:$rPass" | arch-chroot /mnt chpasswd
echo "$user:$uPass" | arch-chroot /mnt chpasswd

umount -R /mnt

echo
echo "Mz's Arch Installer - Process Succeeded"
echo
echo "Type reboot to finish"