#! /usr/bin/env bash

set -e
set -u

# Requires the following environment varaiables to be set:
#   ___XVS_DEFINE_COMMAND_NAME
#   ___XVS_DEFINE_COMMAND_NAMESPACE
#
#   ___XVS_DEFINE_COMMAND_EXECUTABLE_PATH="$(readlink "$0" || echo "$0")"
#
# Optionally, the following environment variables may be set:
#   ___XVS_DEFINE_COMMAND_PARENT_COMMAND_NAME

___XVS_COMMAND_NAME="${___XVS_DEFINE_COMMAND_NAME}"
___XVS_COMMAND_NAMESPACE="${___XVS_DEFINE_COMMAND_NAMESPACE}"
___XVS_COMMAND_FQCN="${___XVS_COMMAND_NAMESPACE}/${___XVS_COMMAND_NAME}"
___XVS_COMMAND_EXECUTABLE_LOCATION_PATH="${___XVS_DEFINE_COMMAND_EXECUTABLE_LOCATION_PATH}"

___XVS_COMMAND_PARENT_COMMAND_NAME="${___XVS_DEFINE_COMMAND_PARENT_COMMAND_NAME-}"
___XVS_COMMAND_EXECUTABLE_ARGS="${@}"

_XVS_RUNTIME_SYSTEM_EXECUTABLE_NAME="${__XVS_RUNTIME_SYSTEM_EXECUTABLE_NAME-xvs}"

_XVS_COMMAND_STATE_NAME_PREVIOUS="${__XVS_COMMAND_STATE_NAME_PREVIOUS-_fsm_entrypoint}"
_XVS_COMMAND_STATE_NAME_CURRENT="${__XVS_COMMAND_STATE_NAME_CURRENT-_fsm_entrypoint}"
_XVS_COMMAND_STATE_TRANSITION_NAME_PREVIOUS="${__XVS_COMMAND_STATE_TRANSITION_NAME_PREVIOUS-_fsm_entrypoint}"
_XVS_COMMAND_STATE_TRANSITION_NAME_NEXT="${__XVS_COMMAND_STATE_TRANSITION_NAME_NEXT-_fsm_entrypoint}"

_XVS_COMMAND_ROUTE_HISTORY="${__XVS_COMMAND_ROUTE_HISTORY-}"

function ___xvs_command_log() {
  local LEVEL="${1}"
  local MESSAGE="${2}"
  echo "XVS[main/command][${___XVS_COMMAND_FQCN}][...->${_XVS_COMMAND_STATE_TRANSITION_NAME_PREVIOUS}->[${_XVS_COMMAND_STATE_NAME_CURRENT}]->${_XVS_COMMAND_STATE_TRANSITION_NAME_NEXT}]:[${LEVEL}] ${MESSAGE}" >&2
}

function ___xvs_command_log_fatal() {
  local EXIT_CODE="${1}"
  local MESSAGE="${2}"
  ___xvs_command_log "FATAL" "${2}"
  declare -p >&2
  exit ${EXIT_CODE}
}

export __XVS_SYSTEM_COMMAND_STATE_EXECUTION_RECURSION_DEPTH=$((${_XVS_SYSTEM_COMMAND_STATE_EXECUTION_RECURSION_DEPTH-0}+1))
_XVS_SYSTEM_COMMAND_STATE_EXECUTION_RECURSION_DEPTH=${__XVS_SYSTEM_COMMAND_STATE_EXECUTION_RECURSION_DEPTH}

if [ ${_XVS_SYSTEM_COMMAND_STATE_EXECUTION_RECURSION_DEPTH} -gt 31 ]; then
  __xvs_command_log_fatal 254 "Execution recursion depth limit exceeded"
fi


case "${_XVS_COMMAND_STATE_NAME_CURRENT}" in

  _fsm_entrypoint)

    case "${_XVS_COMMAND_STATE_TRANSITION_NAME_NEXT}" in

      _fsm_entrypoint)
        ___xvs_command_log_fatal 129 "Implementation Undefined"
        ;;

      *)
        ___xvs_command_log_fatal 130 "Invalid State Transition"
        ;;

    esac
    ;;

  uninitialised)

    case "${_XVS_COMMAND_STATE_TRANSITION_NAME_NEXT}" in

      initialise)

        ___XVS_PROJECT_LOCATION_LIBEXEC_PATH="$(cd "${___XVS_COMMAND_EXECUTABLE_LOCATION_PATH}" && pwd)"
        ___XVS_PROJECT_LOCATION_PATH="${___XVS_PROJECT_LOCATION_LIBEXEC_PATH}/.."
        ___XVS_PROJECT_LOCATION_BIN_NAME="bin"
        ___XVS_PROJECT_LOCATION_BIN_PATH="${___XVS_PROJECT_LOCATION_PATH}/${___XVS_PROJECT_LOCATION_BIN_NAME}"

        export __XVS_RUNTIME_STATE_ENTRYPOINT_COMMAND_NAME="${___XVS_COMMAND_NAME}"
        export __XVS_RUNTIME_STATE_ENTRYPOINT_COMMAND_NAMESPACE="${___XVS_COMMAND_NAMESPACE}"
        export __XVS_RUNTIME_STATE_ENTRYPOINT_COMMAND_PARAMETERS="${___XVS_COMMAND_EXECUTABLE_ARGS}"

        exec "${___XVS_PROJECT_LOCATION_BIN_PATH}/${_XVS_RUNTIME_SYSTEM_EXECUTABLE_NAME}" "${___XVS_COMMAND_PARENT_COMMAND_NAME}" ${___XVS_COMMAND_EXECUTABLE_ARGS}
        ;;

    esac
    ;;

  initialised)

    case "${_XVS_COMMAND_STATE_TRANSITION_NAME_NEXT}" in

      route)

        export __XVS_SYSTEM_RUNTIME_ROUTE_HISTORY="${_XVS_SYSTEM_RUNTIME_ROUTE_HISTORY}:${___XVS_COMMAND_FQCN}"

        exec "${__XVS_PROJECT_LOCATION_LIBEXEC_PATH}/${_XVS_RUNTIME_SYSTEM_EXECUTABLE_NAME}" "${___XVS_COMMAND_PARENT_COMMAND_NAME}" ${___XVS_COMMAND_EXECUTABLE_ARGS}
        ;;

      execute)
        ___xvs_command_log_fatal 129 "Implementation Undefined"
        ;;

      *)
        ___xvs_command_log_fatal 130 "Invalid State Transition"
        ;;

    esac
    ;;

  *)
    ___xvs_command_log_fatal 131 "Invalid Current State Reached. This is a bug in the state transition pre-transition destination validity check."
    ;;

esac
