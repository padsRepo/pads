#!/bin/bash

module="Project Manager"
description="For managing projects on a local repository."
version="1.0.0"
author="Joe Corso <korratheexplora@hotmail.com>"
created="$(date -d '20230605')"
docs="https://github.com/padsRepo"
license="MIT License"
OPTSTRING="p:,f:,g:,h,v"
options="-[<m:,s:,d:>] <name>"
synopsis="<cmd> -[<argument>] -[<option>] <name>"
syntax="${0##*/} -[${OPTSTRING}] ${options}"
base_dir="$(dirname "$(readlink -f "${0%/*}")")"

m_proj(){
  [[ -z ${name} ]] && printf "$0: option requires an argument -- $opt\n * ${0##*/} -h for help\n" && exit
  INFO "git clone --bare /srv/repo/git/${skel} /srv/repo/git/{name}.git"
  ssh pi@rpi400.local "git clone --bare /srv/repo/git/${skel}   /srv/repo/git/${name}.git"
  git clone git+ssh://pi@rpi400.local/srv/repo/git/${name}.git ${project_dir}
  echo "done"
}

s_proj(){
  [[ -z ${name} ]] && printf "$0: option requires an argument -- $opt\n * ${0##*/} -h for help\n" && exit
  [[ ! -d ${project_dir} ]] && INFO "Project doesn't exist..." && exit 1
  . "${project_dir}/venv/bin/activate"
  python ${project_dir}/__init__.py
}

d_proj(){
  [[ -z ${name} ]] && printf "$0: option requires an argument -- $opt\n * ${0##*/} -h for help\n" && exit
  [[ ! -d ${project_dir} ]] && INFO "Project doesn't exist..." && exit
  printf "${project_dir}\n"
  read -p " * Delete? Y/n " confirm
  case ${confirm} in
    "Yes" | "yes" | "Y" | "y" | "")
      INFO "I'm deleting ${project_dir}..."
      sudo rm -r ${project_dir}
      ;;
    "No" | "no" | "N" | "n")
      INFO "Fuck you! I did it anyway. Just kidding, I won't."
      ;;
  esac
}

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
    -p $options Manage a python project
    -f $options Manage a flask project
    -g $options Manage a pygame project
    -h Show usage
    -v Show version
  Ex: ${0##*/} -fm dashboard | ${0##*/} -fs dashboard
  See also: man ${0##*/}, man pads, info pads, pads
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

while getopts $OPTSTRING arg; do
  arg=$arg
  opt=${OPTARG#*-}
  name=${3:-$2}
  case $arg in
    p)
      case $opt in
        m) project_dir="/srv/repo/gitbuild"; skel="skelpy"; func="m";;
        s) project_dir="/srv/repo/gitbuild/${name}"; func="s";;
        d) project_dir="/srv/repo/gitbuild/${name}"; func="d";;
        *) printf "${0}: illegal option -- $opt\n * ${0##*/} -h for help\n"; exit;;
      esac
      ;;
    f)
      case $opt in
        m) project_dir="/srv/http/"; skel="skelfl"; func="m";;
        s) project_dir="/srv/http/${name}"; func="s";;
        d) project_dir="/srv/http/${name}"; func="d";;
        *) printf "${0}: illegal option -- $opt\n * ${0##*/} -h for help\n"; exit;;
      esac
      ;;
    g)
      project_dir="${HOME}/games/${proj}"
      template_dir="game"
      virtualenv_dir="${HOME}/env/games"
      ;;
    h) manual; exit;;
    v) echo $version; exit;;
    *) echo " * ${0##*/} -${mod}h for help"; exit 2;;
  esac
done

[[ $# -eq 1 ]] && printf "$0: option requires an argument -- $mod\n * ${0##*/} -h for help\n"  && exit
${func}_proj
