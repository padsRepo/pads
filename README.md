PADS is a general purpose programming language designed to automate tasks, and run complex scripts in a format that only involves a few flags, and options. The first flag in the syntax is made to access logic from modules which may have their own complex logic. The second flag in the syntax is made to access options that may be available in those modules. PADS also has robust error checking; so you can be sure not to enter the wrong flags. Also see: info pads for the comprehensive guide. The man page may be out of date.

Synopsis:  

~~~bash
        `<cmd> -[<module>] -[<argument>] -[<option>] [name...]`  

        `pads -S -[b,u,i,l,d,r:,m,s,h,v] [name...]`  

        `pads -P -[p:,f:,g:,h,v] -[m:,s:,d-h] <name>`  

        `pads -R -[s:,v,h] <name...>`  

        `pads -T [-h|-v]`  

        `pads -x`  

        `pads -h`  

        `pads -v`  
~~~

## Options  

### System Module

`-S -[b,u,i,l,d,r:,m,s,h,v] [name...]`  
Run automated system scripts and exit. The logic for this module is intended to interact with the OS itself. The options are as follows:  

        `-b`  
        : Backup your system to {set a location}

        `-u` [name...]  
        : Update your machine. If given a name it will attempt to install packages.

        `-i`  
        : Update pads info page. Docs are at: pads/docs/pads.texi

        `-l`  
        : List packages installed on this machine.

        `-d`  
        : Update pads' man page. Docs are at: pads/docs/pads.1.

        `-r` <name...>  
        : Remove supplied packages

        `-m`  
        : Set up Mariadb

        `-v`  
        : Show version

        `-h`  
        : Show help

### Project Module

`-P -[p:|f:|g:|h|v] -[<m|s|d>] <name>`  
Run modules parsed in another language and exit. This module is intended to run full programs. Usually something other than Bash. The m flag is make, the s flag is start, the d flag is delete the project.

        `-p -[<m|s|d>] <name>`  
        : For managing a Python Project or Module.

        `-f -[<m|s|d>] <name>`  
        : For managing a Flask Project or Module.

        `-g -[<m|s|d>] <name>`  
        : For managing a Pygames Project or Module.

        `-h`  
        : Show help for the P module and exit

        `-v`  
        : Show version for the -p module and exit

### Run Module

`-R [-s|-h|-v]`  
Used to run any random script within the r_opts.sh file. This flag is good for testing.

        `-s [<name>]`  
        : Run the given script. Good for scripts that dont fit into a module.

        `-h`  
        : Show help for the R module.

        `-v`  
        : Show version for the R module.

### Test Module

`-T -[arg]` [name] 
For tests scripts

        `-s`  
        : Run script with specified `name`

        `-h`  
        : Show help for PADS and exit.

        **-v`  
        : Show version for PADS and exit

## Exit Status

| Code | Response |
|---|---|
| 0 | Success |
| 1 | Error |
| 2 | Illegal/Required Option |
| 127 | K18 (Command doesn't exist) |
| 130 | Ctl+C |

## Environment

BROWSER="w3m"  
PROMPT_COMMAND=prompt_command  
RANGER_LOAD_DEFAULT=false  
PATH=PATH:HOME/pads/bin  

## Directories

N/A

## History

- PADS is General Purpose Artificial Intelligence designed to carry out every day business tasks. It's purpose is to provide book keeping, employee timesheets, client tracking, automation, etc. It can do double entry accounting for hybrid manufacturing companies. None of the data is loaded as Environment Variables, so your interaction with PADS is between you and it. It's original purpose was to serve as a website, with a relational historical database. Work on this project began in Python using the Django Framework on June 23, 2021 at 5:30pm. The accounting database first came online Oct. 13th, 2021 at 11:48pm. The Bash Syntax was first created by Joe Corso on May 4th, 2022. It was previously codenamed Project Eniac, to pay homage to the original project of the same name.  
- Work began on an Arch Linux distro  
- The original man page was created 2023-09-08  
- Flask Project for Accounting was created  
- Flask API was created  
- Started using Qtile (switched from XFCE4).  
- Created info page  

## Notes

- All new logic files added to ~/pads/module/ must be named by the flag or argument they represent.  
- I wanted to following a syntax which follows the <command> <module> <argument> <option> pattern because I thought it would be easy to code and work with. It seems cryptic with one letter names, but the code is easy, and each function can have its own logic. Most of it being wrappers for more complex commands that already exist anyway, but I have a hard time remembering. I made it similar to pacman just because I liked it.

## Examples

`pads -Ph`  
Show project help and exit

`pads -Pps brain`  
Start a python project named "brain"

`pads -Ppm brain`  
Make a python project named "brain". This will create a virtual env for the project as well.

`pads -Ppd brain`  
Delete the project named "brain". It will ask confirmation as well.

`pads -Su`  
Update your machine.

`pads -Su neofetch`  
Install neofetch to your machine.

`pads -Sb`  
Back up your machine locally.

`pads -x`  
Set the x flag for whatever command you need to debug.
