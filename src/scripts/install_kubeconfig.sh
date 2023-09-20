#!/bin/bash
KUBECONFIG=$(eval echo "$PARAM_KUBECONFIG")
if [ -n "${KUBECONFIG}" ]; then
    mkdir -p "$HOME"/.kube
    echo -n "$KUBECONFIG" | base64 --decode > "$HOME"/.kube/config
fi
