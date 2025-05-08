
---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
---

# (P)roject Module
This manual is for PROJ (0.0.5, 2025-02-26) A module made for PADS
2023-06-05

## Introduction

### Description
The purpose of this module is to automate project management on your machine.
It should build, start, delete and manage the a virual env, projects from differents languages
and web frameworks.

 - Repository: https://github.com/padsRepo/pads

 - Blog: https://padsrepo.github.io/pads/

## Author
Joe Corso

## Version
0.0.5

## Copyright
Copyright (c) 2022 Joe Corso

Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## License
MIT License

# Usage
~~~bash
    <cmd> -[<argument>] -[<option>] [name...]
    proj -[p:,f:,g:,h,v] -[m,s,d] <name>
    -p -[m,s,d] <name> Manage a python project
    -f -[m,s,d] <name> Manage a flask project
    -g -[m,s,d] <name> Manage a pygame project
    -h Show usage
    -v Show version
~~~


# 
# Environment Variables
|Key|Value|
|-----|-----|
\$project_dir | "\${BIN_DIR}/lib/\${proj}" "\${HOME}/srv/\${proj:-\$name}" "\${HOME}/games/\${proj}"
\$template_dir | "python" "flask" "game"

# Files/Directories
|Path|Description|
|-----|-----|
\$HOME/pads/bin/proj | Executable Directory
\$HOME/pads/src/proj/parseopts | Source Code Directory
\$HOME/pads/handler/signales/pads.sig | Directory for signal handlers

# History
- 2025-04-10 This module became it's own command 
- 2025-04-10 Added self generating documentation

# Notes
- This cmd needs to do more things managing virtual envs

# Examples
`proj -fm project && proj -fs project`
: In this example we make and start a Flask project named `project`.

`proj -d project`
: In this example we the project named `project`.

`proj -e flask`
: In this example we manage the virtual environment name `flask`.

# Source Code
  ~~~bash
module="(P)roject Module"
description="For managing projects that are not bash"
version="0.0.5"
author="Joe Corso (https://www.joecorso.com)"
created="$(date -d '20230605')"
docs="https://github.com/padsRepo"
license="MIT License"
OPTSTRING="p:,f:,g:,h,v"
options="-[m,s,d] <name>"
synopsis="<cmd> -[<argument>] -[<option>] [name...]"
syntax="${0##*/} -[${OPTSTRING}] ${options}"
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
    -p $options Manage a python project
    -f $options Manage a flask project
    -g $options Manage a pygame project
    -h Show usage
    -v Show version
  Ex: ${0##*/} -r neofetch | ${0##*/} -u nano neofetch firefox
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
      project_dir="${BIN_DIR}/lib/${proj}"
      template_dir="python"
      echo "This is disabled for now line: $LINENO module: $module_dir/proj/proj"
      exit
      ;;
    f) 
      project_dir="${HOME}/srv/${proj:-$name}"
      template_dir="flask"
      virtualenv_dir="${HOME}/env/flask"
      echo $virtualenv_dir $opt
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
[[ $# -eq 0 ]] && manual  && exit 2
. "${base_dir}/src/proj/parseopts"
${opt}_proj
~~~

# See Also
info pads

