#!/bin/bash

title="${2}"
subtitle=${3}
version="0.1.0"

buildHeaders(){
  cat << EOF
#!/bin/bash

## title ${title}
## subtitle ${subtitle}
## brief
## desc
## author
## email
## created
## repoURL
## docsURL
## blogURL
## version
## copyright
## end copyright
## lic
## synopsis
## syntax
## exit
## end exit
## env
## end env
## file
## end file
## history
## end history
## note
## end note
## example
## end example
## seealso
## sourcecode
## readme
## end readme
EOF
}

buildCMD(){
  cat << BODY
title="${title}"
subtitle="${subtitle}"
version="${version}"
OPTSTRING="h,v"
synopsis="<cmd> -[<module>] -[<argument>] -[<option>] [name...]"
syntax="\${0##*/} -[\${OPTSTRING}] -[arg]"
base_dir="\$(dirname "\$(readlink -f "\${0%/*}")")"

. "\${base_dir}/etc/pads.sig"

description(){
  cat << EOF
 * \${title}
 * \${subtitle}

EOF
}

usage(){
  cat << EOF
  Synopsis: \$synopsis
  Syntax: \$syntax
  Usage:
    -v      Show Version
    -h      Show Usage
  Ex:
  See also:
EOF
}

manual(){
  description
  usage
}

while getopts \${OPTSTRING} name; do
  case \${name} in
    v) echo "\${version}"; exit;;
    h) usage; exit;;
    ?) echo " * \${0##*/} -h for help"; exit 2;;
    *) echo "K18 Error"; exit 2;;
  esac
done
[[ \$# -eq 0 ]] && manual && exit
\$cmd -\$arg
BODY
}

buildHeaders > "${base_dir}/bin/${title}"
buildCMD >> "${base_dir}/bin/${title}"
mkdir "${base_dir}/src/${title}"
chmod +x "${base_dir}/bin/${title}"
#ln "${base_dir}/bin/${title}" /usr/bin
