#!/bin/bash

# Description: Build your library, or meta pkg into a PKGBUILD. This will compress your files into a tar.gz, generate the PKGBUILD, .install, and CHANGELOG.md files into the `pkgbuild/$pkgname` dir. It searches for a `bin/pkgname` file, and if it does not exist it is assumed to be a meta package and will report a fail at the compressing stage.
#
# Args:
#   $1: Name of project to build.
#
# Returns:
#    0: status "[SUCCESS]"
#    1: status "[FAIL]"
#
# Examples:
#    pkgbuild binCmd
#      : First compresses `source/{bin/binCmd,binCmd/*}` into `binCmd.tar.gz`, if it does not find the binCmd file it skips this. Then it creates the `PKGBUILD`, `CHANGELOG.md`, `.install` files. Copies automatically to `${baseDir}/pkgbuild/binCmd/`
pkgbuild(){
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && return 2
  
  . "${baseDir}/${0##*/}/templates.sh"
  . "${baseDir}/${0##*/}/utils.sh"
  
  pkgname=${1}
  #dir="$(locateDirectory ${pkgname}/packaging)"
  pkgbuildDir="$(locateDirectory ${pkgname}/packaging)"

  #[[ ! -d ${pkgbuildDir} ]] && mkdir -p ${pkgbuildDir}
  
  compress ${pkgname} ${pkgbuildDir}
  
  if [[ ! -f ${pkgbuildDir}/PKGBUILD ]]; then
    INFO "Making PKGBUILD..."
    pkgbuildFile ${pkgname} > ${pkgbuildDir}/PKGBUILD
    status $?
  fi
  if [[ ! -f ${pkgbuildDir}/.install ]]; then
    INFO "Making .install..."
    installFile > ${pkgbuildDir}/.install
    status $?
  fi
}

metapkg(){
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && return 2
  
  pkgdir=$(locateDirectory metapkg/${1})
  makepkg -c -D $pkgdir
}

gitpkg(){
  # TODO: Use a git to compile/download source code to work on project and see docs, etc/
  echo $@
}

dryrun(){
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && return 2
  pkgname=${@}
  pkgbuildDir="${rootDir}/pkgbuild/${pkgname}"
  
  makepkg -D ${pkgbuildDir} -o &> /dev/null
  status "Testing PKGBUILD..."
  makepkg -D ${pkgbuildDir} --packagelist &> /dev/null
  status "Testing Package List..."
}

usage(){
  cat << EOF
  Syntax: ${0##*/} -${mod} <arg> <opt>
  Usage:
    -p --pkgbuild <name>  Create a pkg that can be uploaded to an Arch Repo
    -m --metapkg <name>   Create a meta PKGBUILD
    -t --test <name>      Test things
    -h --help             Show Usage
  Ex: ${0##*/} -${mod}p padsutils
EOF
}

