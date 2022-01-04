#!/bin/bash
RESOURCE_FILE_PATH=$(eval echo "$PARAM_RESOURCE_FILE_PATH")
ACTION_TYPE=$(eval echo "$PARAM_ACTION_TYPE")
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
DRY_RUN=$(eval echo "$PARAM_DRY_RUN")
KUSTOMIZE=$(eval echo "$PARAM_KUSTOMIZE")
SERVER_SIDE_APPLY=$(eval echo "$PARAM_SERVER_SIDE_APPLY")
ENVSUBST=$(eval echo "$PARAM_ENVSUBSTR")

[ -w /usr/local/bin ] && SUDO="" || SUDO=sudo

if [ -n "${ACTION_TYPE}" ]; then
    set -- "$@" "${ACTION_TYPE}"

    if [ "${ACTION_TYPE}" == "apply" ] && [ "${SERVER_SIDE_APPLY}" == "true" ]; then
    set -- "$@" --server-side
    fi
fi
if [ -n "$RESOURCE_FILE_PATH" ]; then
    if [ "$ENVSUBST" == "1" ]; then        
        $SUDO apt-get update && $SUDO apt-get install -y gettext-base
        FILENAME="$(basename "$RESOURCE_FILE_PATH")"
        envsubst < "$RESOURCE_FILE_PATH" > /tmp/"$FILENAME"; mv /tmp/"$FILENAME" "$RESOURCE_FILE_PATH"
        echo "THIS WORKS " > test.txt
    fi

    if [ "${KUSTOMIZE}" == "1" ]; then
        set -- "$@" -k
    else
        set -- "$@" -f
    fi
        set -- "$@" "$RESOURCE_FILE_PATH"
fi
if [ -n "${NAMESPACE}" ]; then
    set -- "$@" --namespace="${NAMESPACE}"
fi
if [ -n "${DRY_RUN}" ]; then
    set -- "$@" --dry-run="${DRY_RUN}"
fi
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
fi
kubectl "$@"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set +x
fi
