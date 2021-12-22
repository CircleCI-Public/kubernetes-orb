#!/bin/bash
RESOURCE_NAME=$(eval echo "$PARAM_RESOURCE_NAME")
NAMESPACE=$(eval echo "$PARAM_NAMESPACE")
WATCH_ROLLOUT_STATUS=$(eval echo "$PARAM_WATCH_ROLLOUT_STATUS")
PINNED_REVISION_TO_WATCH=$(eval echo "$PARAM_PINNED_REVISION_TO_WATCH")
WATCH_TIMEOUT=$(eval echo "$PARAM_WATCH_TIMEOUT")

if [ -n "${RESOURCE_NAME}" ]; then
    set -- "$@" "${RESOURCE_NAME}"
fi
if [ -n "${NAMESPACE}" ]; then
    set -- "$@" "--namespace=${NAMESPACE}"
fi
if [ "${WATCH_ROLLOUT_STATUS}" == "true" ]; then
    set -- "$@" --watch=true
    if [ -n "${PINNED_REVISION_TO_WATCH}" ]; then
    set -- "$@" "--revision=${PINNED_REVISION_TO_WATCH}"
    fi
    if [ -n "${WATCH_TIMEOUT}" ]; then
    set -- "$@" "--timeout=${WATCH_TIMEOUT}"
    fi
fi
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set -x
fi
kubectl rollout status "$@"
if [ "$SHOW_EKSCTL_COMMAND" == "1" ]; then
    set +x
fi
