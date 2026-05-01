#!/bin/bash

# Logger for PADS Project using trap
# Version 1.0.0
# Copyright (c) Joe Corso <pads.email.address@gmail.com>
# Part of the pads-meta group/dependency

grey="$(tput setaf 240)$(tput bold)"
blue="$(tput setaf 4)$(tput bold)"
green="$(tput setaf 2)$(tput bold)"
red="$(tput setaf 1)$(tput bold)"
yellow="$(tput setaf 226)$(tput bold)"
orange="$(tput setaf 208)$(tput bold)"
r="$(tput sgr0)"

set -e

INPUT(){
  read -p "${1}" enter
  return $enter
}

INFO(){
  local code=$?
  [[ ${code} -eq 0 ]] && printf "[ ${grey}${FUNCNAME[0]}${r} ] :: ${1}\n[ ${grey}${0##*/}${r} ] :: ${2}"
}

LOG(){
  local code=$?
  [[ ${code} -eq 0 ]] && printf "[ ${0##*/} ] :: ${1}\n" >> "${base_dir}/log/${0##*/}.log"
}

hup_script(){
  notify-send "PADS" "Bye"
}
ERROR(){
  local code=$?
  printf "[ ${red} ${FUNCNAME[0]} ${r} ] :: ${0}.${mod}.$BASH_LINENO: $BASH_COMMAND\n"
  return $code
}

quit_script(){
  printf "Quitting...\n"
  exit 1
}

interrupt_script(){
  printf "\n${yellow}You hit ^C${r}\n"
  [[ -f ${lock} ]] && echo "rm lock" && rm $lock
  exit 130
}

terminate_script(){
  notify-send "Terminated"
  killall $!
}
exit_script(){
  code=$?
  # Code goes here
  exit $code
}
#trap "x=$FUNCNAME" RETURN
trap interrupt_script SIGINT
#trap hup_script SIGHUP
trap exit_script EXIT
trap ERROR ERR
trap quit_script QUIT
#trap "z=$FUNCNAME" DEBUG
#trap "echo Child" SIGCHLD
#trap terminate_script SIGTERM
