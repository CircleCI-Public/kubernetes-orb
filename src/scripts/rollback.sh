#!/bin/bash
RESOURCE_NAME=$(eval echo "$PARAM_RESOURCE_NAME")
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
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
