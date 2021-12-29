#!/bin/bash
RESOURCE_NAME=$(eval echo "$PARAM_RESOURCE_NAME")
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
if [ -n "${NAMESPACE}" ]; then
    set -- "$@" "--namespace=${NAMESPACE}"
fi
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
fi
kubectl describe "${RESOURCE_NAME}" "$@"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set +x
fi


