#!/bin/bash

hup_script(){
  notify-send "tty" "Bye" 2> /dev/null
}
err_script(){
  return $?
}
quit_script(){
  return $?
}
exit_script(){
  code=$?
  # Code goes here
  exit $code
}
trap hup_script SIGHUP
trap exit_script EXIT
trap err_script ERR
#trap quit_script QUIT
#trap debug_script DEBUG
#trap "echo Child" SIGCHLD
#trap terminate_script SIGTERM