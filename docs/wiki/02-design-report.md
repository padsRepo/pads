## Design Report

### Architecture Overview

PADS is organized into four main modules:

- **sys**: Handles OS-level automation, such as package updates, log management, and environment setup.
- **proj**: Manages Python project lifecycles, including project creation, start, stop, and removal.
- **paddocs**: A documentation system that extracts inline docstrings and comments, then renders them into multiple formats (HTML, PDF, Markdown, man pages).
- **tools**: Miscellaneous utilities that support workflows like network scanning, monitoring, or custom scripts.

### Technology Stack

- Git server via `git-shell` or `gitea`
- Documentation served via paddocs-generated HTML
- Network tools (ping, traceroute, nmap, etc.)
- Remote backup target via `rsync` or `restic`
- Flask/Python app testing for local development
- Jellyfin for media

### Data Flow
```
Input command -> process logic -> Output
                                                         -> run LLM -> Output
pads -> process which command to use -> process OPT/ARGS -> pass command to module -> Output
                                                         -> build env -> Output

paddocs ->

proj ->

sys ->

tools ->
```

### Directory Structure
The PADS project uses a clear directory hierarchy:

```
pads/
├── sys/ # System-level scripts
├── proj/ # Python project generators and managers
├── paddocs/ # Documentation system source and config
│ ├── src/
│ ├── config/
│ ├── includes/
│ ├── manuscript/
│ ├── output/
│ └── metadata.yaml
├── tools/ # Helper scripts and utilities
├── models/ # LLM prompts, outputs, and evaluation
├── etc/ # Configuration files
├── var/ # Logs and runtime files
├── install/ # Installation and uninstallation scripts
└── tests/ # Unit and integration tests
```
### UI/UX Design
Built in configs for Qtile, KDE Plasma, Arch Linux  
Built in Conky Panels showing system performance, mounted devices, etc.  
PADS integrates a prompt command:  
- **located at `$PADS_DIR/etc/prompt_command.sh`**

```bash
    promptCommand(){
      local code=$?
      blue="\[$(tput setaf 4)$(tput bold)\]"
      green="\[$(tput setaf 2)$(tput bold)\]"
      red="\[$(tput setaf 1)$(tput bold)\]"
      yellow="\[$(tput setaf 227)$(tput bold)\]"
      orange="\[$(tput setaf 208)$(tput bold)\]"
      grey="\[$(tput setaf 240)$(tput bold)\]"
      r="\[$(tput sgr0)\]"
      bg=${grey}
      ve=${grey}
      f=${grey}
      nx=${grey}
      git=${grey}
      [[ $PWD =~ "git" ]] && git=${orange}
      [[ -n $VIRTUAL_ENV ]] && ve=${orange}
      PS1="[ ${git} ${r} ${ve}VE${r} ${blue}\u@\h \W${r} ] \$ "
    }
```

PADS has it's own set of logging, and error reporting using signal traps:
- **located at: `\$PADS_DIR/etc/pads.sig`**


```bash
    msg(){
      local code=$?
      [[ ${code} -eq 0 ]] && printf "[ ${grey}INFO${r} ] :: ${1}\n"
    }

    hup_script(){
      notify-send "PADS" "Bye"
    }
    err_script(){
      local code=$?
      printf "[$code]$red ERROR:${BASH_SOURCE##*/}:${FUNCNAME[0]}:$r ${0##*/}.${mod}.$BASH_LINENO:$BASH_COMMAND\n"
      return $code
    }
    quit_script(){
      printf "Quitting...\n"
      exit 1
    }
    interrupt_script(){
      printf "\n^C\n"
      [[ -f ${lock} ]] && echo "rm lock" && rm $lock
      exit 130
    }

    terminate_script(){
      notify-send "Terminated"
      killall $!
    }
    exit_script(){
      code=$?
      # Code goes here
      exit $code
    }
```


### Security Considerations

- Secrets are stored separately and encrypted in vaults.
- Logs are rotated and separated by module to facilitate auditing.
- The modular structure minimizes risk by isolating critical scripts.
- Secrets and environment variables managed securely via configuration files and optional encrypted vaults.
- Log files and runtime data separated into `var/` for easy rotation and monitoring.
- `.env` and `pads.conf` allow environment-specific overrides without modifying source code.

### Scalability Plan

- Add Pi-hole, local DNS or DHCP
- Integrate ZeroTier or Tailscale for remote VPN
- Deploy model evaluation or inference client
- Expand with external SSD, NAS, or other SBCs
