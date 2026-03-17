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
#CUSTOM PACKAGES for your project needs
%end
