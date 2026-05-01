#!/bin/bash

module="Tools Module"
description="Running misc scripts. Good for testing"
version="1.0.0"
author="Joe Corso (https://www.joecorso.com)"
created="$(date -d '20230605')"
docs="https://github.com/padsRepo"
license="MIT License"
packages="${@:2}"
OPTSTRING="s,v,h"
synopsis="<cmd> -[<argument>] -[<option>] [name...]"
syntax="${0##*/} -[$OPTSTRING] [name...]"
base_dir="$(dirname "$(readlink -f "${0%/*}")")"

description(){
  cat << EOF
 * ${module}
 * ${description}
 
EOF
}

usage(){
  cat << EOF
  Synopsis: $synopsis
  Syntax: $syntax
  Usage:
   -s  
       passgen           Generate a random password  
       note              Take a note  
       buildpkg          Build Package to install  
       conkystart        Start Conky panels  
       timer <int>       Start a countdown timer for 3 seconds  
       progress          Show a progress bar  
       resetpath         Reset default \$PATH  
   -h                    Show help  
   -v                    Show version  
  Ex: paddocs -c pads -l bash -nmrwxs | paddocs -c paddocs -l bash -wsxp
  See also: man paddocs, info pads
EOF
}

manual(){
  description
  usage
}

while getopts $OPTSTRING arg; do
  opt=${2}
  name=${3}
  case ${arg} in
    s) . "${base_dir}/src/pads/${opt}" ${name}; exit;;
    v) echo "$version"; exit;;
    h) manual; exit;;
    *) echo "$OPTARG * ${0##*/} -${mod}h for help"; exit 2;;
  esac
done
[[ $# -eq 1 ]] && printf "$0: option requires an argument -- $mod\n * ${0##*/} -h for help\n"  && exit
