#!/bin/bash
RESOURCE_NAME="<< parameters.resource-name >>"
NAMESPACE="<< parameters.namespace >>"
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
