# PADS
 PADS is a shell-based automation framework designed to simplify system tasks
and project scaffolding through concise command-line flags. PADS serves as a
wrapper around common system and development tasks,
providing a more streamlined and user-friendly interface.
PADS is designed to support the VCS, Workflow, and CI/CD of
[Operation Mindmap].

 - Repo:  https://github.com/padsRepo/pads/docs/pads.html
 - Blog:  https://padsrepo.github.io/pads/
 - Docs:  https://github.com/padsRepo/pads/wiki
 
## Before you start

Before you begin, make sure you meet these prerequisites:  

* Bash >= 5.2

## Get started

1) Download: `git clone git+ssh://pi@rpi400.local/srv/repo/git/pads.git`

2) Install: `makepkg -si`

3) Add to /etc/pacman.conf:
```bash
[datasphere]
SigLevel = Optional TrustAll
Server = http://rpi400.local/db/core
```

## What's next  

## Examples:
`pads -Cd /path/to/dev/env assets etc config docs`
: Make a new Development Env with the directories `assets`, `etc`, `config` and `docs`. The directory structure can also be stored in a text file.

`pads -Cd /path/to/dev/env/shcmd docs packaging source/bin`
: Make a new bash command. This could be any lang. The directory structure can also be stored in a text file.

`pads -Cf /path/to/dev/env/shcmd CHANGELOG.md README.md LICENSE`
: Make any files needed for the lib. This can be any file in any directory. The file structure can also be stored in a text file.

`pads -Tc shcmd > /path/to/dev/env/shcmd/source/bin/shcmd`
: Make a new bin file with the proper headers and getops, etc. The default output is the terminal, it must be piped to a file.

`pads -Tp shcmd > /path/to/dev/env/shcmd/packaging/PKGBUILD`
: Make a PKGBUILD file for a give cmd. The default output is the terminal, it must be piped to a file.

`pads -Bp shcmd`
: Build the lib into a distribute, or official release. Built in `shcmd/packaging`.

`pads -Ur shcmd`
: Update the local repo located at `/srv/repo/core`.  

## Troubleshooting:
1) turn it off and on again
2) blow on it
3) say 3 hail mary's  

## Contributing:
1. Fork the repo
2. Create a feature branch (`git checkout -b feature-name`)
3. Commit changes (`git commit -m "Add feature"`)
4. Push branch (`git push origin feature-name`)
5. Open a Pull Request  
