%post --log /tmp/post-fix_distro_repos
RP_RELEASE="redpesk-lts-corn-3.0-update"
# RP_RELEASE="redpesk-lts-corn-3.0.0"

echo "Switch to ${RP_RELEASE} release"
if [[ "${RP_RELEASE}" == "redpesk-lts-corn-3.0-update" ]]; then
    echo "Switch on corn-3.0-update release"
    echo "0" > /etc/dnf/vars/redpesk_releasefull
    echo "1" > /etc/dnf/vars/redpesk_update
elif [[ "${RP_RELEASE}" == "redpesk-lts-corn-3.0.0" ]]; then
    echo "1" > /etc/dnf/vars/redpesk_releasefull
    echo "0" > /etc/dnf/vars/redpesk_update
else
    echo "Unsupported ${RP_RELEASE} release"
    exit 1
fi
%end

%packages --ignoremissing --nocore --exclude-weakdeps
NetworkManager-wifi
audit
audit-rules
can-tests
can-utils
chkconfig
chrony
cronie
cronie-anacron
crontabs
dbus-libs
default-fonts-core-sans
diffutils
dmidecode
dnf-plugins-core
dracut-chsmack
dracut-live
dracut-redpesk-common
dtc
duktape
dwz
e2fsprogs
e2fsprogs-libs
efi-srpm-macros
ethtool
file
firewalld
firewalld-filesystem
fonts-filesystem
fonts-srpm-macros
forge-srpm-macros
fuse3-libs
glibc-gconv-extra
glibc-langpack-en
go-srpm-macros
groff-base
hdparm
hostname
hwdata
i2c-tools
inih
initscripts
initscripts-rename-device
initscripts-service
iptables-libs
iputils
irqbalance
iw
jansson
jitterentropy
jq
kernel-srpm-macros
kexec-tools
langpacks-core-en_GB
langpacks-en_GB
langpacks-fonts-en
less
libcbor
libedit
libfdt
libfido2
libi2c
libnetfilter_conntrack
libnfnetlink
libnftnl
libmnl
libpipeline
libselinux-utils
libss
libsss_idmap
libsss_nss_idmap
libusb1
linux-firmware-amphion
linux-firmware-imx
lua-srpm-macros
man-db
ncurses
nftables
numactl-libs
ocaml-srpm-macros
oniguruma
openblas-srpm-macros
openssh-clients
openssl1.1
package-notes-srpm-macros
parted
perl-srpm-macros
picocom
platform-firstboot
platform-runtime-tools
policycoreutils
polkit
polkit-libs
pyproject-srpm-macros
python-srpm-macros
python3-dateutil
python3-dbus
python3-dnf-plugins-core
python3-firewall
python3-gobject-base
python3-gobject-base-noarch
python3-inotify
python3-linux-procfs
python3-nftables
python3-pyudev
python3-six
python3-systemd
qt6-srpm-macros
redhat-mono-vf-fonts
redhat-rpm-config
redhat-text-vf-fonts
redpesk-bsp-repos-corn
redpesk-repos-config
rng-tools
rootfiles
rust-toolset-srpm-macros
sssd-client
sudo
tar
tree
tuned
uboot-tools
unzip
usbutils
userspace-rcu
virt-what
wget
wireless-regdb
wpa_supplicant
xfsprogs
yum
yum-utils
zip
%end
