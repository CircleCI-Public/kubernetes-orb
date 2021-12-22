#!/bin/bash
KOPS_VERSION=$(eval echo "$PARAM_KOPS_VERSION")
if [[ KOPS_VERSION == "latest" ]]; then
    # get latest kops release
    KOPS_VERSION=$(curl -s https://api.github.com/repos/kubernetes/kops/releases/latest | grep tag_name | cut -d '"' -f 4)
fi

PLATFORM="linux"
if [ -n "$(uname | grep "Darwin")" ]; then
    PLATFORM="darwin"
fi

# download kops
curl -LO https://github.com/kubernetes/kops/releases/download/$KOPS_VERSION/kops-$PLATFORM-amd64

[ -w /usr/local/bin ] && SUDO="" || SUDO=sudo

$SUDO chmod +x kops-$PLATFORM-amd64

$SUDO mv kops-$PLATFORM-amd64 /usr/local/bin/kops
