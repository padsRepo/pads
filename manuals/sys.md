
---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
---

# (S)ystem Module
This manual is for SYS (0.0.5, 2025-02-26) A module made for PADS
2023-06-05

## Introduction

### Description
The purpose of this module is to automate system commands on your machine.
It should be able to build your DE, WM, configs, install the OS, set up
your bashrc, backup your machine, etc.

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
   sys -[b,u,i,l,d,r:,m,s,h,v] [name...]
   -b           Backup System
   -u [name...] Update machine. Supply name of package to install.
   -i           Update pads' info page
   -l           List packages on this machine
   -d           Update pads' man page
   -r <name...> Remove supplied packages
   -m           Set up mariadb
   -s           Show system information
   -h           Show help
   -v           Show version
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
\$HOME/pads/bin/sys | Executable Directory
\$HOME/pads/src/sys/<function> | Source Code Directory
\$HOME/pads/handler/signales/pads.sig | Directory for signal handlers

# History
- 2025-04-10 This module became it's own command 
- 2025-04-10 Added self generating documentation

# Notes
- This cmd needs to do more of things I describe.

# Examples
`sys -m`
: In this example we set up mariadb on our system, including the secure-install, and generating a user and password.

`sys -u`
: In this example we update the system and enter the password.

`sys -u neofetch ranger btop ...`
: In this example we install as many packages as we want seperated by spaces.
: You can use `pacman` or `yay`.

# Source Code
  ~~~bash
module="(S)ystem Module"
description="Running system commands on your machine."
version="0.0.5"
author="Joe Corso (https://www.joecorso.com)"
created="$(date -d '20230605')"
docs="https://github.com/padsRepo"
license="MIT License"
packages="${@:2}"
OPTSTRING="b,u,i,l,d,r:,m,s,h,v"
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
 Synopsis: ${synopsis}
 Syntax: ${syntax}
 Usage:
   -b           Backup System
   -u [name...] Update machine. Supply name of package to install.
   -i           Update pads' info page
   -l           List packages on this machine
   -d           Update pads' man page
   -r <name...> Remove supplied packages
   -m           Set up mariadb
   -s           Show system information
   -h           Show help
   -v           Show version
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
  
while getopts $OPTSTRING name; do
  arg=$name
  case $arg in
    b) function="backup";;
    u) function="update";;
    i) function="updateinfo";;
    l) pacman -Qqen; exit;;
    d) function="updateman";;
    r) sudo pacman -Rcns $packages; exit;;
    m) function="setupmariadb";;
    s) function="sysinfo";;
    h) usage; exit;;
    v) echo "$version"; exit;;
    ?) echo " * ${0##*/} -${mod}${arg}h for help"; exit 2;;
  esac
done
[[ -z $arg ]] && manual  && exit 2
. "${base_dir}/src/sys/${function}"
~~~

# See Also
sys, proj, tools, man pads, info pads

