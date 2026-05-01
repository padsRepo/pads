#!/bin/bash

title="(S)ystem Module"
description="Running system commands on your machine."
version="1.0.0"
author="Joe Corso <pads.email.address@gmail.com>"
created="$(date -d '20230605')"
docs="https://github.com/padsRepo"
license="MIT License"
packages="${@:3}"
OPTSTRING="b,u,l,r:,m,s,h,v"
synopsis="<cmd> -[<argument>] -[<option>] [name...]"
syntax="${0##*/} -[$OPTSTRING] [name...]"
base_dir="$(dirname "$(readlink -f "${0%/*}")")"

description(){
  cat << EOF
 * title
 * ${description}

EOF
}

usage(){
 cat << EOF
 Synopsis: ${synopsis}
 Syntax: ${syntax}
 Usage:
   -b           Backup System
   -u [name...] Update machine. Supply name of package to install.
   -l           List packages on this machine
   -r <name...> Remove supplied packages
   -m           Set up mariadb
   -s           Show system information
   -h           Show help
   -v           Show version
  Ex: ${0##*/} -Su | ${0##*/} -Su nano neofetch firefox | ${0##*/} -Sm
  See also: man ${0##*/}, info pads
  Author: $author
  Version: $version
  Created: $created
  $license
EOF
}

manual(){
  description
  usage
}

while getopts $OPTSTRING name; do
  arg=$name
  case $arg in
    b) function="backup"; . "${base_dir}/src/pads/${function}"; exit;;
    u) function="update"; . "${base_dir}/src/pads/${function}"; exit;;
    l) pacman -Qqen; exit;;
    r) sudo pacman -Rcns $packages; exit;;
    m) function="setupmariadb"; . "${base_dir}/src/pads/${function}"; exit;;
    s) function="sysinfo"; . "${base_dir}/src/pads/${function}"; exit;;
    h) usage; exit;;
    v) echo "$version"; exit;;
    ?) echo " * ${0##*/} -${mod}${arg}h for help"; exit 2;;
  esac
done

[[ $# -eq 1 ]] && printf "${0##*/}: option requires an argument -- $mod\n * ${0##*/} -h for help\n"  && exit

