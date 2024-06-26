#! /bin/bash

clear

echo -e "Mz's Arch Installer\nThis installer works once connected to internet and created the partition table"
echo

sleep 1

# Time and date sync
timedatectl set-ntp true

# User Configurations
echo "Hostname: "
read hostname

echo -e "User: \c"
read user

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
    echo "Use SWAP partition? [y/n]"
    read tSw

    case $tSw in
        [Yy]* ) echo -e "Write path of SWAP: \c"
                read swap

                mkswap $swap

                if (($? == 1))
                then
                    echo -e "Invalid partition, try again \n"
                    continue
                fi

                swapon $swap

                break;;
        
        [Nn]* ) echo "No swap partition will be used"
                break;;

        * ) echo "Invalid option, try again"
            continue;;
    esac
done

# Pacman Keyring and Pacstrap
pacman-key --init
pacman-key --populate archlinux

while true
do
    echo "Select a linux kernel"
    echo "1. Stable"
    echo "2. Zen"
    read $tKn

    case $tKn in
        1 ) kernel = "linux"
            break;;
        
        2 ) kernel = "linux-zen"
            break;;
        
        * ) echo "Invalid option, try again"
            continue;;
    esac
done

pacstrap /mnt base base-devel neovim linux-firmware $kernel $kernel-headers mkinitcpio fastfetch curl wget git --noconfirm --needed

# Fstab file generation and chroot
genfstab -U /mnt >> /mnt/etc/fstab

cat <<EOF > /mnt/tmp/temp.sh

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

cat <<EOF > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   $hostname.localdomain   $hostname
EOF

# Root Password
echo
echo "Write Root User Password"
echo

passwd

# Add User and Password
useradd -m -g users -G wheel -s /bin/bash $user

echo
echo "Write $user Password"
echo

passwd $user

# Add user to sudoers file
sed -i "s/^root ALL=(ALL:ALL) ALL/root ALL=(ALL:ALL) ALL\n$user ALL=(ALL:ALL) ALL/" /etc/sudoers

# Pacman Config File
sed -i "s/^#color/color" /etc/pacman.conf
sed -i "s/^#VerbosePkgLists/VerbosePkgLists" /etc/pacman.conf
sed -i "s/^#ParallelDownloads = 5/ParallelDownloads = 5\nILoveCandy" /etc/pacman.conf
sed -i "s/^#\\[multilib\\]/\\[multilib\\]/" /etc/pacman.conf
sed -i "s|^#Include = /etc/pacman.d/mirrorlist|Include = /etc/pacman.d/mirrorlist|" /etc/pacman.conf
pacman -Syu

# Install Fundamentals
pacman -S networkmanager wireless_tools grub efibootmgr os-prober xdg-user-dirs

# Enable Services
systemctl enable NetworkManager

# Create File tree on root and user
xdg-user-dirs-update
su $user -c "xdg-user-dirs-update"

# Grub Config

while true
do
    echo "Is this an removable device installation? [y/n]"
    read tGb

    case $tGb in
        [Yy]* ) echo "Installing removable media Grub"
                grub-install --target=x86-64-efi --efi-directory=/boot --removable
                break;;
        
        [Nn]* ) echo "Installing non-removable media Grub"
                grub-install --target=x86-64-efi --efi-directory=/boot --bootloader-id=$hostname
                break;;
        
        * ) echo "Invalid option, try again"
            continue;;
    esac
done

cat <<EOF >> /etc/default/grub

# Last selected OS
GRUB_SAVEDEFAULT=true
EOF

sed -i "s/^#GRUB_DISABLE_OS_PROBER=false/GRUB_DISABLE_OS_PROBER=false/" /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

exit

EOF

arch-chroot /mnt /tmp/temp.sh

umount -R /mnt

echo
echo "Mz's Arch Installer - Process Succeeded"
echo

echo "Device will reboot in 3 seconds..."

sleep 1

echo "Device will reboot in 2 seconds.."

sleep 1

echo "Device will reboot in 1 seconds."

sleep 1

echo "Device rebooting now!"

reboot