#!/bin/bash
KUBECTL_VERSION=$(eval echo "$K8_STR_KUBECTL_VERSION")
MAX_TIME=$(eval echo "$K8_BOOL_MAX_TIME")
if [ "$KUBECTL_VERSION" == "latest" ]; then
    # get latest kubectl release
    KUBECTL_VERSION=$(curl -sL https://dl.k8s.io/release/stable.txt)
fi

if [[ "$KUBECTL_VERSION" =~ ^v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Valid version format."
else
  echo "Invalid version format: ${KUBECTL_VERSION}" 
  echo "Please use the format vX.Y.Z (e.g., v1.29.0)."
  exit 1
fi

PLATFORM="linux"
if uname | grep "Darwin"; then
    PLATFORM="darwin"
fi

ARCH="arm64"
if uname -m | grep "x86_64"; then
    ARCH="amd64"
fi

# download kubectl
if [ "$MAX_TIME" == "1" ]; then
    curl --max-time 300 -LO https://dl.k8s.io/release/"${KUBECTL_VERSION}"/bin/"${PLATFORM}"/"${ARCH}"/kubectl
else 
    curl -LO https://dl.k8s.io/release/"${KUBECTL_VERSION}"/bin/"${PLATFORM}"/"${ARCH}"/kubectl
fi

[ -w /usr/local/bin ] && SUDO="" || SUDO=sudo

$SUDO chmod +x ./kubectl

$SUDO mv ./kubectl /usr/local/bin
