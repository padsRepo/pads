#!/bin/env bash

dryrun(){
  pkgbuildFile $1
  echo $version $subtitle
}

usage(){
  cat << EOF
  Syntax: ${0##*/} -${mod} <arg> <opt>
  Usage:
    -p --pkgbuild <name>       Create PKGBUILD File. Must specify directory.
    -i --install               Create .install File. Must specify directory.
    -c --command <name>        Create bin command File. Must specify directory.
    -l --pyprojectFile <name>  Create pyproject.toml file
    -x --pycli <name>          Create CLI file for a py project
    -t --test <name>           Test things
    -h --help                  Show Usage
  Ex: ${0##*/} -${mod}p padsutils > /path/to/dir/PKGBUILD
EOF
}