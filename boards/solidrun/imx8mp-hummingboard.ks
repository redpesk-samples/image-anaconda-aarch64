zerombr
clearpart --all --disklabel=gpt

# Add an offset on the first part (/boot) to let some space for firmware
part /boot  --fstype ext4 --size 512 --asprimary --label=boot --start=10

%post --erroronfail --nochroot --log /mnt/sysroot/tmp/post-solidrun-imx8mp-hummingboard.log
# Copy the u-boot binary at the Solidrun board's expected offset
dd if=/mnt/sysroot/boot/flash.bin of=/dev/mapper/Redpesk-OS bs=1024 seek=32 conv=fsync
%end

%packages --ignoremissing --nocore --exclude-weakdeps
uboot
solidrun-firmware
-*grubby
-grubby-deprecated
-extlinux-bootloader
-fedora-arm-installer
-grub2-common
-grub2-tools
-grub2-tools-minimal
-plymouth
-shim*
%end
