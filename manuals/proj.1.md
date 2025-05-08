
---
title: (P)roject Module
section: 1
header: Man Page
footer: proj 0.0.5
date: 2023-06-05
---

# NAME
(P)roject Module This manual is for PROJ (0.0.5, 2025-02-26) A module made for PADS

# SYNOPSIS
    <cmd> -[<argument>] -[<option>] [name...]
    proj -[p:,f:,g:,h,v] -[m,s,d] <name>

# DESCRIPTION
The purpose of this module is to automate project management on your machine.
It should build, start, delete and manage the a virual env, projects from differents languages
and web frameworks.

# OPTIONS
    -p -[m,s,d] <name> Manage a python project
    -f -[m,s,d] <name> Manage a flask project
    -g -[m,s,d] <name> Manage a pygame project
    -h Show usage
    -v Show version

# EXAMPLES
`proj -fm project && proj -fs project`
: In this example we make and start a Flask project named `project`.

`proj -d project`
: In this example we the project named `project`.

`proj -e flask`
: In this example we manage the virtual environment name `flask`.

# EXIT STATUS
|Code|Status|
|-----|-----|
0 | Success
1 | Failure
127 | K18
130 | Ctl+C


# NOTES
- This cmd needs to do more things managing virtual envs

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
info pads
