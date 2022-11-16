#!/bin/bash
KUBECTL_VERSION=$(eval echo "$PARAM_KUBECTL_VERSION")
MAX_TIME=$(eval echo "$PARAM_MAX_TIME")
if [ "$KUBECTL_VERSION" == "latest" ]; then
    # get latest kubectl release
    KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
fi

PLATFORM="linux"
if uname | grep -q "Darwin"; then
    PLATFORM="darwin"
fi

# download kubectl
if [ "$MAX_TIME" == "1" ]; then
    curl --max-time 300 -LO https://storage.googleapis.com/kubernetes-release/release/"$KUBECTL_VERSION"/bin/"$PLATFORM"/amd64/kubectl
else 
    curl -LO https://storage.googleapis.com/kubernetes-release/release/"$KUBECTL_VERSION"/bin/"$PLATFORM"/amd64/kubectl
fi

[ -w /usr/local/bin ] && SUDO="" || SUDO=sudo

$SUDO chmod +x ./kubectl

$SUDO mv ./kubectl /usr/local/bin
