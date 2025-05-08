
---
title: (S)ystem Module
section: 1
header: Man Page
footer: sys 0.0.5
date: 2023-06-05
---

# NAME
(S)ystem Module This manual is for SYS (0.0.5, 2025-02-26) A module made for PADS

# SYNOPSIS
   <cmd> -[<argument>] -[<option>] [name...]
   sys -[b,u,i,l,d,r:,m,s,h,v] [name...]

# DESCRIPTION
The purpose of this module is to automate system commands on your machine.
It should be able to build your DE, WM, configs, install the OS, set up
your bashrc, backup your machine, etc.

# OPTIONS
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

# EXAMPLES
`sys -m`
: In this example we set up mariadb on our system, including the secure-install, and generating a user and password.

`sys -u`
: In this example we update the system and enter the password.

`sys -u neofetch ranger btop ...`
: In this example we install as many packages as we want seperated by spaces.
: You can use `pacman` or `yay`.

# EXIT STATUS
|Code|Status|
|-----|-----|
0 | Success
1 | Failure
127 | K18
130 | Ctl+C


# NOTES
- This cmd needs to do more of things I describe.

# AUTHORS
Joe Corso

# REPORTING BUGS
pads.email.address@gmail.com

# COPYRIGHT
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

# SEE ALSO
sys, proj, tools, man pads, info pads
