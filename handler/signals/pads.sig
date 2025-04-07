#!/bin/bash

blue="$(tput setaf 4)$(tput bold)"
green="$(tput setaf 2)$(tput bold)"
red="$(tput setaf 1)$(tput bold)"
yellow="$(tput setaf 226)$(tput bold)"
orange="$(tput setaf 208)$(tput bold)"
r="$(tput sgr0)"

hup_script(){
  notify-send "PADS" "Bye"
}
err_script(){
  local code=$?
  printf "[$code]$red ERROR:${BASH_SOURCE##*/}:${FUNCNAME[0]}:$r ${0##*/}.${mod}.$BASH_LINENO:$BASH_COMMAND\n"
  return $code
}
quit_script(){
  printf "Quitting...\n"
  exit 1
}
interrupt_script(){
  printf "\n^C\n"
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
trap err_script ERR
trap quit_script QUIT
#trap "z=$FUNCNAME" DEBUG
#trap "echo Child" SIGCHLD
#trap terminate_script SIGTERM