#!/bin/bash
RESOURCE_FILE_PATH=$(eval echo "$PARAM_RESOURCE_FILE_PATH")
RESOURCE_NAME=$(eval echo "$PARAM_RESOURCE_NAME")
CONTAINER_IMAGE_UPDATES=$(eval echo "$PARAM_CONTAINER_IMAGE_UPDATES")
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
DRY_RUN=$(eval echo "$PARAM_DRY_RUN")
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
