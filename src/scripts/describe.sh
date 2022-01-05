#!/bin/bash
RESOURCE_NAME=$(eval echo "$PARAM_RESOURCE_NAME")
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
RESOURCE_FILE_PATH=$(eval echo "$PARAM_RESOURCE_FILE_PATH")
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


