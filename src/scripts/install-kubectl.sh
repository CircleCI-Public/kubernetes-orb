#!/bin/bash
KUBECTL_VERSION=$(eval echo "$PARAM_KUBECTL_VERSION")
if [[ "$KUBECTL_VERSION" == "latest" ]]; then
    # get latest kubectl release
    KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
fi

PLATFORM="linux"
if [ -n "$(uname | grep "Darwin")" ]; then
    PLATFORM="darwin"
fi

# download kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/$KUBECTL_VERSION/bin/$PLATFORM/amd64/kubectl

[ -w /usr/local/bin ] && SUDO="" || SUDO=sudo

$SUDO chmod +x ./kubectl

$SUDO mv ./kubectl /usr/local/bin
