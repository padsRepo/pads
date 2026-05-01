#!/bin/bash

promptCommand(){
  local code=$?
  blue="\[$(tput setaf 4)$(tput bold)\]"
  green="\[$(tput setaf 2)$(tput bold)\]"
  red="\[$(tput setaf 1)$(tput bold)\]"
  yellow="\[$(tput setaf 227)$(tput bold)\]"
  orange="\[$(tput setaf 208)$(tput bold)\]"
  grey="\[$(tput setaf 240)$(tput bold)\]"
  r="\[$(tput sgr0)\]"
  bg=${grey}
  ve=${grey}
  f=${grey}
  nx=${grey}
  git=${grey}
  [[ $PWD =~ "git" ]] && git=${orange}
  [[ -n $VIRTUAL_ENV ]] && ve=${orange}
  PS1="[ ${git} ${r} ${ve}${r} ${blue}\u@\h \W${r} ] \$ "
}

promptCommand1(){
  local code=$?
  blue="\[$(tput setaf 4)$(tput bold)\]"
  green="\[$(tput setaf 2)$(tput bold)\]"
  red="\[$(tput setaf 1)$(tput bold)\]"
  yellow="\[$(tput setaf 227)$(tput bold)\]"
  orange="\[$(tput setaf 208)$(tput bold)\]"
  grey="\[$(tput setaf 19)$(tput bold)\]"
  r="\[$(tput sgr0)\]"
  bg=${grey}
  ve=${grey}
  f=${grey}
  nx=${grey}
  git=${grey}
  case $code in
    0) color="$green";char="";text=":)";;
    1 | 2 | 127) color=$red;char="";text=":(";;
    130 | 131) color=$yellow;char="󰈅";text=":o";;
    142) color=$yellow;char="";text="Timed Out";;
    148) color=$yellow;char="󰯰";text="󰯰";;
  esac
  [[ $(jobs | grep "+") ]] && bg=$orange
  [[ -n ${VIRTUAL_ENV} ]] && ve=$orange
  [[ $(ps aux | grep "pads -Pfs") ]] && f=$orange
  [[ $(systemctl status nginx.service 2> /dev/null | grep "active") ]] && nx=$orange
  [[ $(pwd | grep "gitRepo") ]] && git=$orange
  PS1="${blue}[ ${color}${char} ${code} ${bg}󰯰 ${ve}${f}  ${nx} ${git} ${blue}\W ] \$ ${r}"
}

promptCommand2(){
  local code=$?
  blue="\[$(tput setaf 4)$(tput bold)\]"
  green="\[$(tput setaf 2)$(tput bold)\]"
  red="\[$(tput setaf 1)$(tput bold)\]"
  yellow="\[$(tput setaf 227)$(tput bold)\]"
  orange="\[$(tput setaf 208)$(tput bold)\]"
  grey="\[$(tput setaf 19)$(tput bold)\]"
  r="\[$(tput sgr0)\]"
  case $code in
    0) color="$green";char="";text=":)";;
    1 | 2 | 127) color=$red;char="";text=":(";;
    130 | 131) color=$yellow;char="󰈅";text=":o";;
    142) color=$yellow;char="";text="Timed Out";;
    148) color=$yellow;char="󰯰";text="󰯰";;
  esac
  PS0="${blue}[ ${color}${char} ${code} ${text} ]\n${r}"
  PS1="${blue}[ \W ] \$ ${r}"
}

PROMPT_COMMAND=promptCommand
