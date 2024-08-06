#! /usr/bin/env nix-shell
#! nix-shell -i bash -p bash

declare -A _=(
)
declare -A __xvs_module_lib_system_log_=(
  ["imports"]=
  ["exports"]=
  ["defines"]=
)

__xvs__mount __xvs__module __xvs_module_lib_system __xvs_module__lib_system_log

__XVS_SYSTEM_LOG_ENABLED="${__XVS_SYSTEM_LOG_ENABLED}-1"
__XVS_SYSTEM_LOG_COMMAND="${__XVS_SYSTEM_LOG_COMMAND-echo}"
__XVS_SYSTEM_LOG_LEVEL="${__XVS_SYSTEM_LOG_LEVEL-.:critical}"

if [ "${__XVS_SYSTEM_LOG_LEVEL}" ?? ".:critical" ]; then
  __XVS_SYSTEM_LOG__FILTER_CAM = 0
else

function _XVS_SYSTEM_LOG_ {
  local ENDPOINT = ${0}
}

function _XVS_SYSTEM_LOG_ {
}

function _XVS_SYSTEM_LOG_ {
}

function _XVS_SYSTEM_LOG_ {
}

function _XVS_SYSTEM_LOG {
  if [ ${__XVS_SYSTEM__FILTER_CAM}  ]; then
    ${__XVS_SYSTEM_LOG_COMMAND} ${1}
  fi
}
