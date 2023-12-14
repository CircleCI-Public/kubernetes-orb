#!/bin/bash
RESOURCE_FILE_PATH=$(eval echo "$K8_STR_RESOURCE_FILE_PATH")
ACTION_TYPE=$(eval echo "$K8_STR_ACTION_TYPE")
NAMESPACE=$(eval echo "$K8_STR_NAMESPACE")
DRY_RUN=$(eval echo "$K8_STR_DRY_RUN")
KUSTOMIZE=$(eval echo "$K8_STR_KUSTOMIZE")
SERVER_SIDE_APPLY=$(eval echo "$K8_BOOL_SERVER_SIDE_APPLY")
ENVSUBST=$(eval echo "$K8_BOOL_ENVSUBST")

[ -w /usr/local/bin ] && SUDO="" || SUDO=sudo

if [ -n "${ACTION_TYPE}" ]; then
    set -- "$@" "${ACTION_TYPE}"

    if [ "${ACTION_TYPE}" == "apply" ] && [ "$SERVER_SIDE_APPLY" == "1" ]; then
    set -- "$@" --server-side
    fi
fi
if [ -n "$RESOURCE_FILE_PATH" ]; then
    if [ "$ENVSUBST" == "1" ]; then        
        $SUDO apt-get update && $SUDO apt-get install -y gettext-base
        FILENAME="$(basename "$RESOURCE_FILE_PATH")"
        envsubst < "$RESOURCE_FILE_PATH" > /tmp/"$FILENAME"; mv /tmp/"$FILENAME" "$RESOURCE_FILE_PATH"
    fi
    if [ "$KUSTOMIZE" == "1" ]; then
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
if [ "$K8_BOOL_SHOW_KUBECTL_COMMAND" == "1" ]; then
    set -x
fi

    kubectl "$@"

if [ "$K8_BOOL_SHOW_KUBECTL_COMMAND" == "1" ]; then
    set +x
fi
