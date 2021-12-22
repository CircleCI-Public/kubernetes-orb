#!/bin/bash
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
if [ -n "${NAMESPACE}" ]; then
    set -- "$@" "--namespace=${NAMESPACE}"
fi
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
fi
kubectl describe "${NAMESPACE}" "$@"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set +x
fi


