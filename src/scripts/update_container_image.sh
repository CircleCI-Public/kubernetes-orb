#!/bin/bash
RESOURCE_FILE_PATH=$(eval echo "$K8_STR_RESOURCE_FILE_PATH")
RESOURCE_NAME=$(eval echo "$K8_STR_RESOURCE_NAME")
CONTAINER_IMAGE_UPDATES=$(eval echo "$K8_STR_CONTAINER_IMAGE_UPDATES")
NAMESPACE=$(eval echo "$K8_STR_NAMESPACE")
DRY_RUN=$(eval echo "$K8_STR_DRY_RUN")

if [ -n "${RESOURCE_FILE_PATH}" ]; then
    set -- "$@" -f
    set -- "$@" "${RESOURCE_FILE_PATH}"
elif [ -n "${RESOURCE_NAME}" ]; then
    set -- "$@" "${RESOURCE_NAME}"
else
    echo "Error: The update-container-image command requires either resource-file-path or resource-name to be specified."
    exit 1
fi

if [ -n "${CONTAINER_IMAGE_UPDATES}" ]; then
    IFS=" " read -a args -r <<< "${CONTAINER_IMAGE_UPDATES[@]}"
    for arg in "${args[@]}"; do
        set -- "$@" "$arg"
    done
fi

if [ -n "${NAMESPACE}" ]; then
    set -- "$@" --namespace="${NAMESPACE}"
fi
if [ -n "${DRY_RUN}" ]; then
    set -- "$@" --dry-run "${DRY_RUN}"
fi
if [ "$K8_BOOL_SHOW_KUBECTL_COMMAND" == "1" ]; then
    set -x
fi

    kubectl set image "$@"

if [ "$K8_BOOL_SHOW_KUBECTL_COMMAND" == "1" ]; then
    set +x
fi
