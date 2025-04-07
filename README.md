PADS(1)                                     Comprehensive Documentation                                     PADS(1)

NAME
       PADS - Personal Assistant and Deployment System

SYNOPSIS
       <cmd> -[<module>] -[<argument>] -[<option>] [name...]

       pads -S -[b,u,i,l,d,r:,m,s,h,v] [name...]

       pads -P -[p:,f:,g:,h,v] -[m:,s:,d-h] <name>

       pads -R -[s:,v,h] <name...>

       pads -T [-h|-v]

       pads -x

       pads -h

       pads -v

DESCRIPTION
       PADS is a general purpose programming language designed to automate tasks, and run complex scripts in a for‐
       mat  that only involves a few flags, and options.  The first flag in the syntax is made to access logic from
       modules which may have their own complex logic.  The second flag in the syntax is  made  to  access  options
       that  may be available in those modules.  PADS also has robust error checking; so you can be sure not to en‐
       ter the wrong flags.  Also see: info pads for the comprehensive guide.  This may become out  of  date  if  I
       forget to up‐ date it.

OPTIONS
   -S -[b,u,i,l,d,r:,m,s,h,v] [name...]
       Run  automated  system  scripts and exit.  The logic for this module is intended to interact with the OS it‐
       self.  The options are as follows:

       -b     Backup your system to {set a location}

       -u [name...]
              Update your machine.  If given a name it will attempt to install packages.

       -i     Update pads info page.  Docs are at: pads/docs/pads.texi

       -l     List packages installed on this machine.

       -d     Update pads’ man page.  Docs are at: pads/docs/pads.1.

       -r <name...>
              Remove supplied packages

       -m     Set up Mariadb

       -h     Show help

   -P -[p:|f:|g:|h|v] -[<m|s|d>] <name>
       Run modules parsed in another language and exit.  This module is intended to  run  full  programs.   Usually
       something other than Bash.  The m flag is make, the s flag is start, the d flag is delete the project.

       -p -[<m|s|d>]
              For managing a Python Project or Module.

       -f -[<m|s|d>]
              For managing a Flask Project or Module.

       -g -[<m|s|d>]
              For managing a Pygames Project or Module.

       -h     Show help for the P module and exit

       -v     Show version for the -p module and exit

   -R [-s|-h|-v]
       Used to run any random script within the r_opts.sh file.  This flag is good for testing.

       -s [<name>]
              Run the given script.  Good for scripts that dont fit into a module.

       -h     Show help for the R module.

       -v     Show version for the R module.

   -T -[arg]
       For tests scripts

       -h     Show help for PADS and exit.

       -v     Show version for PADS and exit

EXAMPLES
       pads -Ph
       Show project help and exit

       pads -Ppm brain; pads -Pps brain
       Make then start a python project named “brain”.  This will create a virtual env for the project as well.

       pads -Pfm brain; pads -Pfs brain
       Make a flask project named “brain”.  This will create a virtual env for the project as well.

       pads -Ppd brain
       Delete the project named “brain”.  It will ask confirmation as well.

       pads -Su
       Update your machine.

       pads -Su neofetch ...
       Install neofetch to your machine.

       pads -Sb
       Back up your machine locally.

EXIT STATUS
       Code   Response
       ───────────────────────────────────
       0      Success
       1      Error
       2      Illegal/Required Option
       127    K18 (Command doesn’t exist)
       130    Ctl+C

NOTES
       1. Man Page Updates:

           • Created 09-8-2023
           • Updated 09-24-2023
           • Fixed Notes Section 20-20-2023
           • Updated 12-03-2023
           • Updated 12-27-2023
           • Updated 05-13-2024
           • Chaged Syntax 09-02-2024
           • Changed Syntax 02-26-2025
           • forked from original pads.1 to markdown 2025-03-20

AUTHORS
       Joe Corso (2022)- Creator/Main Developer

REPORTING BUGS
       pads.email.address@gmailmail.com?subject=PADS%20bug

COPYRIGHT
       MIT License Copyright (c) 2022 Joe Corso

       Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
       documentation files (the “Software”), to deal in the Software without restriction, including without limita‐
       tion  the  rights  to  use,  copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the
       Software, and to permit persons to whom the Software is furnished to do so, subject to the following  condi‐
       tions:  The above copyright notice and this permission notice shall be included in all copies or substantial
       portions of the Software.  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,  EXPRESS  OR  IM‐
       PLIED,  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
       NONINFRINGEMENT.  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR  ANY  CLAIM,  DAMAGES  OR
       OTHER  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
       WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

SEE ALSO
       sys, proj, tools, info pads

pads 0.0.5                                           2025-02-26                                             PADS(1)
