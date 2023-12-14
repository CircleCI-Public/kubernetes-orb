#!/bin/bash
RESOURCE_NAME=$(eval echo "$K8_STR_RESOURCE_NAME")
NAMESPACE=$(eval echo "$K8_STR_NAMESPACE")
if [ -n "${RESOURCE_NAME}" ]; then
    set -- "$@" "${RESOURCE_NAME}"
fi
if [ -n "${NAMESPACE}" ]; then
    set -- "$@" "--namespace=${NAMESPACE}"
fi
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
fi
kubectl rollout undo "$@"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set +x
fi
