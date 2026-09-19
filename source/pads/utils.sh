#!/bin/env bash

extract(){
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && exit 2
  
  pkgname="${1}"
  binFile=$(locateBinary $pkgname)
  if [[ -f $binFile ]]; then
    . $binFile 2> /dev/null
    pkgver=${version}
    sub=${subtitle}
  fi
}

compress(){
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && exit 2
  
  binFile="$(locateBinary ${1})"
  extract $1
  #if [[ -f ${binFile} ]]; then
  cd ${binFile%source*}
  INFO "Compressing ${pkgname}..."
  tar -cf ${pkgbuildDir}/${pkgname}-${pkgver}.tar.gz ./source/{bin/${pkgname},${pkgname}/*} &> /dev/null
  status $?
  #fi
}