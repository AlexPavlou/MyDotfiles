#!/bin/sh
linux_ver=$(eselect kernel show | tr -d ' [a-zA-Z]:/-')
#cd /usr/src/linux
#doas make -j12
#doas make modules_install
#doas mount /dev/nvme0n1p6 /boot
#doas rm -rf /boot/*{$linux_ver}*
#doas make install
#doas dracut --lz4 --kver=$linux_ver --force
#cd /boot
#doas grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=gentoo
#doas grub-mkconfig -o /boot/grub/grub.cfg
#doas refind-install
