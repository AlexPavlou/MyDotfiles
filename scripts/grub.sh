doas grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=Gentoo &
doas grub-mkconfig -o /boot/grub/grub.cfg &
doas refind-install
