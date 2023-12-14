#!/bin/bash
RESOURCE_NAME=$(eval echo "$K8_STR_RESOURCE_NAME")
NAMESPACE=$(eval echo "$K8_STR_NAMESPACE")
RESOURCE_FILE_PATH=$(eval echo "$K8_STR_RESOURCE_FILE_PATH")
if [ -n "${RESOURCE_FILE_PATH}" ]; then
    if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
    fi
    kubectl describe -f "${RESOURCE_FILE_PATH}"
    if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
        set +x
    fi
else
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
fi


