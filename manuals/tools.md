
---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
---

# (R)un Module
This manual is for TOOLS (0.0.5, 2025-02-26) A module made for PADS
2023-06-05

## Introduction

### Description
The purpose of this module is to run random scripts on your machine.

 - Repository: https://github.com/padsRepo/pads

 - Blog: https://padsrepo.github.io/pads/

## Author
Joe Corso

## Version
0.0.3

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
  
    tools -[s,v,h] [name...]
   -s
     passgen           Generate a random password
     note              Take a note
     buildpkg          Build Package to install
     conkystart        Start Conky panels
     timer <int>       Start a countdown timer for 3 seconds
     progress          Show a progress bar
     resetpath         Reset default $PATH
   -h                  Show help
   -v                  Show version
~~~


# Exit Status
|Code|Status|
|-----|-----|
0 | Success
1 | Failure
127 | K18
130 | Ctl+C

# Environment Variables
|Key|Value|
|-----|-----|
None | N/A

# Files/Directories
|Path|Description|
|-----|-----|
\$HOME/pads/bin/tools | Executable Directory
\$HOME/pads/src/tools/<function> | Source Code Directory
\$HOME/pads/handler/signales/pads.sig | Directory for signal handlers

# History
- 2025-04-10 This module became it's own command 

# Notes
- I probably dont need this

# Examples
`tools -s genpass`
: In this example we generate a random password.

`tools -s timer 10`
: In this example we start a countdown timer for 10 seconds.

`tools -s note`
: In this example we start the note taking app.

# Source Code
  ~~~bash
module="(R)un Module"
description="Running misc scripts. Good for testing"
version="0.0.3"
author="Joe Corso (https://www.joecorso.com)"
created="$(date -d '20230605')"
docs="https://github.com/padsRepo"
license="MIT License"
packages="${@:2}"
OPTSTRING="s,v,h"
synopsis="<cmd> -[<argument>] -[<option>] [name...]"
syntax="${0##*/} -[$OPTSTRING] [name...]"
base_dir="$(dirname "$(readlink -f "${0%/*}")")"
. "${base_dir}/handler/signals/pads.sig"
description(){
  cat << EOF
 * ${module}
 * ${description}
 
EOF
}
usage(){
  cat << EOF
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
   -h                  Show help
   -v                  Show version
EOF
}
manual(){
  description
  usage
}
while getopts $OPTSTRING arg; do
  opt=${OPTARG}
  name=${3:-$2}
  case ${arg} in
    s) . "${base_dir}/src/tools/${name}" $OPTARG; exit;;
    v) echo "$version"; exit;;
    h) manual; exit;;
    *) echo "$OPTARG * ${0##*/} -${mod}h for help"; exit 2;;
  esac
done
[[ $# -eq 0 ]] && manual  && exit 2
~~~

# See Also
info pads

