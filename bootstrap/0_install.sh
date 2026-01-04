#!/bin/bash
read -p "Introduce the HOST name (f.e., MyArch): " HOSTNAME

if [ -z "$HOSTNAME" ]; then
  echo "Error: The hostname can't be empty."
  exit 1
fi

echo "Syncing clock..."
timedatectl set-ntp true

echo "Installing base system (pacstrap)..."
pacstrap /mnt base linux linux-firmware base-devel networkmanager git nano

echo "Generating fstab..."
genfstab -U /mnt >> /mnt/etc/fstab

echo "Configuring base system..."
arch-chroot /mnt /bin/bash <<EOF
# Localization:
ln -sf /usr/share/zoneinfo/America/Asuncion /etc/localtime
hwclock --systohc
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Host name
echo "$HOSTNAME" > /etc/hostname

# Installation of bootloader (UEFI)
# Note: Asumes it is mounted the EFI partition in /mnt/boot
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# Root password
echo "Set the password for ROOT user for the new system:"
passwd
EOF

echo "----------------------------------------------------"
echo "LEVEL 0 PROCESS IS FINISHED."
echo "Host set as: $HOSTNAME_VAR"
echo "You can now execute: umount -R /mnt && reboot"
echo "----------------------------------------------------"
