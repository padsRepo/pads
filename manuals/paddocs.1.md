
---
title: Paddocs
section: 1
header: Man Page
footer: paddocs 0.0.1
date: 2025-04-08
---

# NAME
Paddocs This manual is for PADDOCS (0.0.6, 2025-04-09) A module which self-generates documentation

# SYNOPSIS
    <cmd> -[<argument>] [<name>]
    paddocs -[c:,l:,n,m,r,w,q,x,p,s,f,v,h] [<name>]

# DESCRIPTION
Paddocs is a module for PADS which self generates documentation from code into a wiki, blog, info, and man pages.
This documentation was generated using the same library.

# OPTIONS
    -c <name> Command to generate docs for
    -l <name> Coding language to use for the code block.
    -n        Gen HTML
    -m        Gen LICENSE
    -r        Gen README
    -w        Gen Wiki
    -q        Gen Main
    -x        Gen Wiki Home
    -s        Gen Source
    -p        Gen Man Page
    -f        Gen PDF Doc
    -v        Show Version
    -h        Show Usage

# EXAMPLES
`pads -Pfm project && pads -Pfs project`
: In this example we make and start a Flask project named `project`.

`pads -Su`
: In this example we update the system and enter the password.

`pads -Su neofetch ...`
: In this example we install as many packages as we want seperated by spaces.
  You can use `pacman` or `yay`.

# EXIT STATUS
|Code|Status|
|-----|-----|
0 | Success
1 | Error


# NOTES
Headers:
 - title
 - subtitle
 - brief
 - desc
 - author
 - email
 - created
 - repoURL
 - docsURL
 - blogURL
 - version
 - copyright, end copyright
 - lic
 - synopsis
 - syntax
 - usageOpts (This is generated from the `usage()` function)
 - exit, end exit
 - env, end env
 - file, end file
 - history, end history
 - note, end note
 - example, end example
 - seealso
 - sourcecode
 - quickstart, end quickstart

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
man paddocs, info pads
