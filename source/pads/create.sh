#!/bin/bash

# Description: Create a project in the proper base directory, with the proper directory structure. This does not create any files, just directories
#
# Args:
#   $1: Base directory for project
#   $2: List of directories. Can be array or text file.
#
# Returns:
#    0 | 1: status "${FUNCNAME} ${rootDir}/${f}..."
#    2: status "${dir} does not exist...$(CODE 2)"
#
# Examples:
#    createDir assets lib etc src share/{config,logs,utils}
#      : Create dir structure from an array separated by spaces. Using bash syntax for dirs is valid.
#    createDir $HOME/devEnv devEnv.txt
#      : Create dir structure from a .txt file. The list must be separated by spaces or a new line.
#    createDir $HOME/devEnv/cmd shEnv.txt
#      : Create dir structure from a .txt file within a directory. The list must be separated by spaces or a new line.
createDir(){
  [[ $# -le 1 ]] && printf "Syntax: ${FUNCNAME[0]} <baseDir> <dirs...>\n" && return 2

  dir=${@:2}
  if [[ ${dir} =~ ".t" ]]; then 
    profileDir="$(locateBinary $dir)"
    [[ ! -f ${profileDir} ]] && INFO "${dir} does not exist...\n" && return 2
    dir=$(cat ${profileDir})
  fi
  
  for d in ${dir[@]}; do
    INFO "${FUNCNAME} ${1}/${d}..."
    mkdir -p "${1}/${d}"
    status 
  done
}

# Description: Create the files needed for each project
#
# Args:
#   $1: List of directories. Can be array or text file.
#
# Returns:
#    0 | 1: status "${FUNCNAME} ${rootDir}/${f}..."
#    2: status "${file} does not exist...$(CODE 2)"
#
# Examples:
#    createFile README.md CHANGELOG.md LICENSE docs/{architecture.md,index.md,designReport.md}
#      : Create file structure from an array separated by spaces. Using bash syntax for dirs is valid.
#    createFile fileStructure.txt
#      : Create file structure from a .txt file. The list must be separated by spaces or a new line.
#    createFile file/my-file-structure.txt
#      : Create file structure from a .txt file within a directory. The list must be separated by spaces or a new line.
createFile(){
  [[ $# -le 1 ]] && printf "Syntax: ${FUNCNAME[0]} <baseDir> <dirs...>\n" && return 2

  files=${@:2}
  if [[ ${files} =~ ".t" ]]; then 
    profileDir="$(locateBinary $files)"
    [[ ! -f ${profileDir} ]] && INFO "${files} does not exist...\n" && return 2
    files=$(cat ${profileDir})
  fi
  
  for f in ${files[@]}; do
    INFO "${FUNCNAME} ${1}/${f}..."
    touch "${1}/${f}"
    status 
  done
}

usage(){
  cat << EOF
  Syntax: ${0##*/} -${mod} <arg> <opt>
  Usage:
    -d --directory <baseDir> [<dirname.txt>|<filename.txt|<name...>]  Create project directory
    -f --file <name...>                                   Create files for project
    -h --help                                             Show Usage
  Ex: ${0##*/} -${mod}d asssets lib src etc share | ${0##*/} -${mod}d devDir.txt
EOF
}

