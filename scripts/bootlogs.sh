wget https://cdn.rawgit.com/Korni22/b2d05cbb1836efd79642/raw/e87d0e571aba1efbb9582f70af6d158ef60091e9/grub
mv grub /etc/default/grub
grub2-mkconfig -o /boot/grub2/grub.cfg
