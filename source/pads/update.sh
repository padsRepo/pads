#!/bin/bash

# Description: Update the `Datasphere` repository with the given `${pkgname}`. This will generate the proper files from the `PKGBUILD`, backup the project to `pkg/core/${pkgname}`, and update the Repository.
#
# Args:
#   $1: Name of project to build.
#
# Returns:
#    0: status "[SUCCESS]"
#    1: status "[FAIL]"
#
# Examples:
#    updateRepo binCmd
#      : First runs `makepkg` commands to build the lib to `*.pkg.tar.zst`. Then copies and moves the proper files to the proper directories. Then deletes old versions from the repo and installs the newest one.
updateRepo(){
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && return $?
  
  pkgname=${1}
  [[ ! -d /srv/repo/pkg/core/${pkgname} ]] && sudo mkdir -p /srv/repo/pkg/core/${pkgname}

  pkgbuildDir="$(locateDirectory ${pkgname}/packaging)"
  # Find pkgname and pkgver from the pkgbuild should be made at this point. We don't need to hunt for the variables.
  . ${pkgbuildDir}/PKGBUILD 
  
  makepkg --printsrcinfo -D ${pkgbuildDir} > ${pkgbuildDir}/.SRCINFO
  makepkg -sf --clean -D ${pkgbuildDir}

  sudo rm /srv/repo/db/core/$pkgname-*.pkg.tar.zst
  sudo cp ${pkgbuildDir}/{PKGBUILD,.install,.SRCINFO,$pkgname-$pkgver.tar.gz} /srv/repo/pkg/core/${pkgname}
  sudo mv ${pkgbuildDir}/$pkgname-$pkgver-1-x86_64.pkg.tar.zst /srv/repo/db/core
  cd /srv/repo/db/core
  sudo repo-remove datasphere.db.tar.zst $pkgname
  sudo repo-add datasphere.db.tar.zst $pkgname-$pkgver-1-x86_64.pkg.tar.zst
  #cp datasphere.db.tar.zst datasphere.db
}

usage(){
  cat << EOF
  Syntax: ${0##*/} -${mod} <arg> <opt>
  Usage:
    r -r --updateRepo <name>  Update repository with given pkg (<name>).
    h -h --help               Show Usage
  Ex: ${0##*/} -${mod}p padsutils > /path/to/dir
EOF
}

