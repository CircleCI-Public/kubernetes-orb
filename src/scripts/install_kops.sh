#!/bin/bash
KOPS_VERSION=$(eval echo "$K8_STR_KOPS_VERSION")
if [[ "$KOPS_VERSION" == "latest" ]]; then
    # get latest kops release
    KOPS_VERSION=$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)
fi

PLATFORM="linux"
if uname | grep "Darwin"; then
    PLATFORM="darwin"
fi

ARCH="arm64"
if uname -m | grep "x86_64"; then
    ARCH="amd64"
fi
# download kops
curl -Lo kops https://github.com/kubernetes/kops/releases/download/"${KOPS_VERSION}"/kops-"${PLATFORM}"-"${ARCH}"

[ -w /usr/local/bin ] && SUDO="" || SUDO=sudo

$SUDO chmod +x kops
$SUDO mv kops /usr/local/bin/kops
