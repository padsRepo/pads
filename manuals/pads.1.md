
---
title: PADS
section: 1
header: Man Page
footer: pads 0.0.6
date: 2023-06-05
---

# NAME
PADS This manual is for PADS (0.0.6, 2025-04-09) Personal Assistant and Deployment System

# SYNOPSIS
    <cmd> -[<module>] -[<argument>] -[<option>] [name...]
    pads -[S:,P:,R:,T,x,v,h] -[arg]

# DESCRIPTION
PADS is a library of binary commands used to automate system tasks in a
format that only involes a few flags, and options. The concept of PADS is
to provide understandable feedback, and help to work through complex workflows.
PADS also has robust error checking; so you can be sure not to enter the wrong flags. 

# OPTIONS
    -S [-h] System Module
    -P [-h] Project Module
    -R [-h] Utilities Module
    -T [-h] Test Module
    -x      Set -x
    -v      Show Version
    -h      Show Usage

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
1 | Failure
127 | K18
130 | Ctl+C


# NOTES
- All new logic files added to `~/pads/module/` must be named by the
   flag or argument they represent.
- I wanted to following a syntax which follows the `<command>`
   `<module>` `<argument>` `<option>` pattern
   because I thought it would be easy to code and work with. It seems
   cryptic with one letter names, but the code is easy, and each
   function can have its own logic. Most of it being wrappers for more
   complex commands that already exist anyway, but I have a hard time
   remembering. I made it similar to pacman just because I liked it.

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
