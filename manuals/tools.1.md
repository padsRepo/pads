
---
title: (R)un Module
section: 1
header: Man Page
footer: tools 0.0.3
date: 2023-06-05
---

# NAME
(R)un Module This manual is for TOOLS (0.0.5, 2025-02-26) A module made for PADS

# SYNOPSIS
  
    tools -[s,v,h] [name...]

# DESCRIPTION
The purpose of this module is to run random scripts on your machine.

# OPTIONS
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

# EXAMPLES
`tools -s genpass`
: In this example we generate a random password.

`tools -s timer 10`
: In this example we start a countdown timer for 10 seconds.

`tools -s note`
: In this example we start the note taking app.

# EXIT STATUS
|Code|Status|
|-----|-----|
0 | Success
1 | Failure
127 | K18
130 | Ctl+C


# NOTES
- I probably dont need this

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
