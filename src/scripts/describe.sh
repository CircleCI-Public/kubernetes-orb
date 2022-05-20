#!/bin/bash
RESOURCE_NAME=$(eval echo "$PARAM_RESOURCE_NAME")
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
SHOW_KUBECTL_COMMAND=$(eval echo "$PARAM_SHOW_KUBECTL_COMMAND")
RESOURCE_FILE_PATH=$(eval echo "$PARAM_RESOURCE_FILE_PATH")


if [ -n "${RESOURCE_FILE_PATH}" ]; then
    if [ "$SHOW_KUBECTL_COMMAND" == "1" ]; then
    set -x
    fi
    kubectl describe -f "${RESOURCE_FILE_PATH}"
    if [ "$SHOW_KUBECTL_COMMAND" == "1" ]; then
        set +x
    fi
else
    if [ -n "${NAMESPACE}" ]; then
        set -- "$@" "--namespace=${NAMESPACE}"
    fi
    if [ "$SHOW_KUBECTL_COMMAND" == "1" ]; then
        set -x
    fi
    kubectl describe "${RESOURCE_NAME}" "$@"
    if [ "$SHOW_KUBECTL_COMMAND" == "1" ]; then
        set +x
    fi
fi
