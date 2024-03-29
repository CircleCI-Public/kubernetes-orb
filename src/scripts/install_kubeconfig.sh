#!/bin/bash
set -x
KUBECONFIG=$(eval echo "\$$K8_ENV_KUBECONFIG")
if [ -n "${KUBECONFIG}" ]; then
    mkdir -p "$HOME"/.kube
    echo -n "$KUBECONFIG" | base64 --decode > "$HOME"/.kube/config
fi
set +x
