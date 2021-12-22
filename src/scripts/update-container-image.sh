#!/bin/bash
RESOURCE_FILE_PATH=$(eval echo "$RESOURCE_FILE_PATH")
RESOURCE_NAME=$(eval echo "$RESOURCE_FILE_PATH")
CONTAINER_IMAGE_UPDATES=$(eval echo "$RESOURCE_FILE_PATH")
NAMESPACE=$(eval echo "$RESOURCE_FILE_PATH")
DRY_RUN=$(eval echo "$RESOURCE_FILE_PATH")
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
    set -- "$@" ${CONTAINER_IMAGE_UPDATES}
fi
if [ -n "${NAMESPACE}" ]; then
    set -- "$@" --namespace="${NAMESPACE}"
fi
if [ -n "${DRY_RUN}" ]; then
    set -- "$@" --dry-run "${DRY_RUN}"
fi
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
fi
kubectl set image "$@"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set +x
fi
