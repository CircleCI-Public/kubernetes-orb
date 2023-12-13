#!/bin/bash
RESOURCE_FILE_PATH=$(eval echo "$KUBERNETES_STR_RESOURCE_FILE_PATH")
RESOURCE_TYPES=$(eval echo "$KUBERNETES_STR_RESOURCE_TYPES")
RESOURCE_NAMES=$(eval echo "$KUBERNETES_STR_RESOURCE_NAMES")
LABEL_SELECTOR=$(eval echo "$KUBERNETES_STR_LABEL_SELECTOR")
ALL=$(eval echo "$KUBERNETES_BOOL_ALL")
CASCADE=$(eval echo "$KUBERNETES_STR_CASCADE")
FORCE=$(eval echo "$KUBERNETES_BOOL_FORCE")
GRACE_PERIOD=$(eval echo "$KUBERNETES_INT_GRACE_PERIOD")
IGNORE_NOT_FOUND=$(eval echo "$KUBERNETES_BOOL_IGNORE_NOT_FOUND")
NOW=$(eval echo "$KUBERNETES_BOOL_NOW")
WAIT=$(eval echo "$KUBERNETES_BOOL_WAIT")
NAMESPACE=$(eval echo "$KUBERNETES_STR_NAMESPACE")
DRY_RUN=$(eval echo "$KUBERNETES_STR_DRY_RUN")
KUSTOMIZE=$(eval echo "$KUBERNETES_STR_KUSTOMIZE")
if [ -n "${RESOURCE_FILE_PATH}" ]; then
    if [ "${KUSTOMIZE}" == "1" ]; then
    set -- "$@" -k
    else
    set -- "$@" -f
    fi
    set -- "$@" "${RESOURCE_FILE_PATH}"
elif [ -n "${RESOURCE_TYPES}" ]; then
    set -- "$@" "${RESOURCE_TYPES}"
    if [ -n "${RESOURCE_NAMES}" ]; then
    set -- "$@" "${RESOURCE_NAMES}"
    elif [ -n "${LABEL_SELECTOR}" ]; then
    set -- "$@" -l
    set -- "$@" "${LABEL_SELECTOR}"
    fi
fi
if [ "${ALL}" == "true" ]; then
    set -- "$@" --all=true
fi
if [ "${FORCE}" == "true" ]; then
    set -- "$@" --force=true
fi
if [ "${GRACE_PERIOD}" != "-1" ]; then
    set -- "$@" --grace-period="${GRACE_PERIOD}"
fi
if [ "${IGNORE_NOT_FOUND}" == "true" ]; then
    set -- "$@" --ignore-not-found=true
fi
if [ "${NOW}" == "true" ]; then
    set -- "$@" --now=true
fi
if [ -n "${NAMESPACE}" ]; then
    set -- "$@" --namespace="${NAMESPACE}"
fi
if [ -n "${DRY_RUN}" ]; then
    set -- "$@" --dry-run="${DRY_RUN}"
fi
set -- "$@" --wait="${WAIT}"
set -- "$@" --cascade="${CASCADE}"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
fi
kubectl delete "$@"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set +x
fi
