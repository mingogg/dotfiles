#!/bin/bash
set -e
read -p "Introduce the HOST name (f.e., MyArch): " HOSTNAME
read -p "Introduce the USER name(f.e., MyName): " USERNAME

HOSTNAME=${HOSTNAME:-emptyHostName}
USERNAME=${USERNAME:-emptyUserName}

read -s -p "Introduce ROOT password: " ROOT_PASS
echo
read -s -p "Confirm ROOT password: " ROOT_PASS_CONFIRM
echo
[[ "$ROOT_PASS" != "$ROOT_PASS_CONFIRM" ]] && exit 1

read -s -p "Introduce USER password: " USER_PASS
echo
read -s -p "Confirm USER password: " USER_PASS_CONFIRM
echo
[[ "$USER_PASS" != "$USER_PASS_CONFIRM" ]] && exit 1

echo "Syncing clock..."
timedatectl set-ntp true

echo "Updating package databases and keyring..."
pacman -Syu --noconfirm archlinux-keyring

mountpoint -q /mnt || {
  echo "/mnt is not mounted"
  exit 1
}
mountpoint -q /mnt/boot || {
  echo "Error: EFI partition is not mounted at /mnt/boot"
  exit 1
}

echo "Installing base system (pacstrap)..."
pacstrap /mnt base linux linux-firmware base-devel networkmanager git nano grub efibootmgr

echo "Generating fstab..."
genfstab -U /mnt > /mnt/etc/fstab

echo "Configuring base system..."
arch-chroot /mnt /bin/bash <<EOF
# Localization:
ln -sf /usr/share/zoneinfo/America/Asuncion /etc/localtime
hwclock --systohc

if ! grep -q "en_US.UTF-8 UTF-8" /etc/locale.gen; then
  echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
fi
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# Setting the host name
echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts <<EOL
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain $HOSTNAME
EOL

# Installation of bootloader (UEFI)
# Note: Asumes it is mounted the EFI partition in /mnt/boot
# First: normal entry
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck
# After: compatibility entry (removable) for rescue
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --removable

grub-mkconfig -o /boot/grub/grub.cfg

# Setting user and passwords
id "$USERNAME" &>/dev/null || useradd -m -G wheel -s /bin/bash "$USERNAME"

echo "root:$ROOT_PASS" | chpasswd
echo "$USERNAME:$USER_PASS" | chpasswd

# Installing & configuring sudo
pacman -S sudo --noconfirm
grep -q '^%wheel ALL=(ALL:ALL) ALL' /etc/sudoers || \
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Activating network
systemctl enable NetworkManager
EOF

echo "----------------------------------------------------"
echo "LEVEL 0 PROCESS IS FINISHED."
echo "Host set as: $HOSTNAME"
echo "You can now execute: umount -R /mnt && reboot"
echo "----------------------------------------------------"
