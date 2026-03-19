# Note that only 3 primary parts are available (the 4th is used to create the extended parts)

# Setup specific partition scheme of redpesk
# /boot defined in boards/solidrun
part /      	--fstype ext4 --size 2048   --label=rootfs  --fsoptions="noatime,rw"

# Setup boot.scr used by uboot
# /dev/mmcblk1p2 matches partition / defined above
%packages --ignoremissing --nocore --exclude-weakdeps
uboot-tools
%end

%post --logfile=/tmp/post-uboot-bootscr.log --erroronfail

cat <<'EOF' > /boot/bootscript.txt
setenv mmcroot /dev/mmcblk1p2 rootwait rw
setenv bootargs ${jh_clk} console=${console} root=${mmcroot} security=smack 
load mmc 1:1 ${loadaddr} Image
load mmc 1:1  ${fdt_addr_r} imx8mp-hummingboard-pulse.dtb
booti ${loadaddr} - ${fdt_addr_r}
EOF
mkimage -A arm -C none -T script -O u-boot -n "Redpesk boot script" -d /boot/bootscript.txt /boot/boot.scr

dnf remove -y uboot-tools
%end

# Correctly set UUID in /etc/fstab
%post --nochroot --logfile=/tmp/post-fstab.log --erroronfail
echo "Setting UUID into /etc/fstab..."
grep "^/dev.*Redpesk*" /mnt/sysroot/etc/fstab | while read part ; do
	dev=$(echo $part | cut -d' ' -f1)
	label=$(echo $part | cut -d' ' -f2)
	label="${label##*/}"
	if [[ "$label" == "" ]]; then
		label="rootfs"
	elif [[ "$label" == "efi" ]]; then
		label="EFI"
	fi
	UUID=$(blkid -s UUID -o value `blkid -L $label`)
	echo "dev=$dev UUID=$UUID label=$label"
	sed -i "s|${dev}|UUID=\"${UUID}\"|g" /mnt/sysroot/etc/fstab
done
cat /mnt/sysroot/etc/fstab
%end
