---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
 - author: Joe Corso
 - title: Website Managemt
 - email: pads.email.address@gmail.com
 - copyright: All Rights Reserved 2025
 - created: 2025-04-18
 - subtitle: Making managing websites a breeze
---

# Motivation

I have an issue where every other week I think of new ways to organize my files. I'll sit around for hours and hours thinking of all the different naming schemas I could use, make the directories, copy everything over, and instantly decide I don't like it, and want to change it again. But I would never write down any diagrams, or my thoughts. So I figured with this new found power of documentation, I could tackle this problem once and for all.

# Thought Process
## Day 1
*2025-05-02*

I think I'll just start by saying I don't know where to start. Which is probably why I keep having this problem. I need all the documents laid out to be easy to understand. Maybe I could make the whole $HOME directory different. I wonder if it could be more interactive somehow, and have the documents directory laid out so that it can be navigated via an `index.md` file. I wonder if I could also put it on a separate partition, so when the $HOME directory needs to be cleaned, all the code is safe. I'll probably just stick with the $HOME directory to keep everything in one place. I could also `mount` the `/mnt` devices to the $HOME directory so it's easyier to navigate. But I wonder how that would affect Jellyfin. I can just keep all that at the traditional `/mnt` so it's separated out, and won't depend on access to *my* specific user account.

Maybe I could start with something like this:

~~~
/home
├── env 
├── games
├── git
├── pads
├── srv
├── templates
├── themes
├── tmp
└── utils
~~~

There's a few things to add. So let's change a few things around to get it closer to this:

~~~
/home
├── archive
├── docs
├── downloads
├── env
├── git
├── pads
├── srv
├── templates
├── themes
├── tmp
├── utils
└── vault
~~~

That's good. Let's focus on the `docs` directory:

~~~
docs
├── companyA
├── companyB
├── guides
├── notes
├── paddocs
├── personal
└── tutorials
~~~

I don't mind that. Let's see about setting up `paddocs` directory to be more interactive:

~~~
paddocs/
├── index.md                # Master table of contents or intro
├── manuals/                # Formal structured guides
│   ├── paddocs.md
│   ├── pads.md
│   └── sys.md
├── references/             # Technical references and schemas
│   ├── glossary.md
│   ├── config_schema.yaml
│   └── changelog.md
├── templates/              # Reusable markdown/YAML templates
│   ├── daily_log.yaml
│   └── programming_log.yaml
├── diagrams/               # Visual assets
│   ├── architecture.svg
│   └── workflow.png
└── archive/                # Old or superseded material
    └── legacy_docs/

~~~

After some thinking, I decided to tweak it, and go with this:

~~~
paddocs/
├── blogs
├── index.md
├── manuals
├── print
├── references
├── templates
└── web
~~~

I fed it ChatGPT to add comments for me real quick. Which breaks down further into this:

~~~
paddocs/                       # Root directory for the PADDOCS self-generating documentation module
├── blogs/                     # Blog-style articles or announcements about PADDOCS or related projects
│   ├── index.md               # Blog index listing all blog posts
│   └── project_paddocs.md     # A blog post discussing the PADDOCS project
├── index.md                   # Top-level documentation index or entry point (likely Markdown-based)
├── manuals/                   # Manual pages (man/info-style) for various modules or commands
│   ├── paddocs.md             # Manual for the PADDOCS system
│   ├── pads.md                # Manual for the core PADS framework
│   ├── proj.md                # Manual for project structure or usage
│   ├── sys.md                 # System-level documentation or administrative guide
│   └── tools.md               # Manual for auxiliary tools used within the system
├── print/                     # Printable (PDF) versions of the manuals
│   ├── paddocs.pdf            # PDF export of the PADDOCS manual
│   ├── pads.pdf               # PDF export of the PADS manual
│   ├── proj.pdf               # PDF export of the project manual
│   ├── sys.pdf                # PDF export of the system manual
│   └── tools.pdf              # PDF export of the tools manual
├── references/                # Supporting reference documents
│   ├── footnotes.md           # Footnotes or extended references used across docs
│   ├── glossary.md            # Terminology and definitions used in the system
│   ├── LICENSE.md             # License for the documentation or project (e.g. MIT)
│   └── README.md              # Project overview or contributor guide
├── templates/                 # HTML/CSS templates used for generating web documentation
│   ├── jez.css                # Custom stylesheet for styling generated HTML docs
│   └── jez.html               # HTML template used in rendering documentation pages
└── web/                       # Generated static HTML output for browser-based documentation
    ├── index.html             # Main index page of the web documentation
    ├── paddocs.html           # HTML version of the PADDOCS manual
    ├── pads.html              # HTML version of the PADS manual
    ├── proj.html              # HTML version of the project manual
    ├── sys.html               # HTML version of the system manual
    └── tools.html             # HTML version of the tools manual
~~~

So we have our whole `docs` directory:

~~~
docs/
├── companyA
│   ├── chartofaccounts.pdf
│   ├── cover.pdf
│   ├── structure.pdf
│   └── title.pdf
├── companyB
│   ├── chartofaccounts.pdf
│   ├── cover.pdf
│   ├── structure.pdf
│   └── title.pdf
├── guides
│   ├── man
│   ├── tutorials
│   └── workflows
├── notes
│   ├── notes.txt
│   ├── pc_build.md
│   └── projects.txt
├── paddocs
│   ├── blogs
│   │   ├── index.md
│   │   └── project_paddocs.md
│   ├── index.md
│   ├── manuals
│   │   ├── paddocs.md
│   │   ├── pads.md
│   │   ├── proj.md
│   │   ├── sys.md
│   │   └── tools.md
│   ├── print
│   │   ├── paddocs.pdf
│   │   ├── pads.pdf
│   │   ├── proj.pdf
│   │   ├── sys.pdf
│   │   └── tools.pdf
│   ├── references
│   │   ├── footnotes.md
│   │   ├── glossary.md
│   │   ├── LICENSE.md
│   │   └── README.md
│   ├── templates
│   │   ├── jez.css
│   │   └── jez.html
│   └── web
│       ├── index.html
│       ├── paddocs.html
│       ├── pads.html
│       ├── proj.html
│       ├── sys.html
│       └── tools.html
├── personal
│   ├── Army_Contract.pdf
│   └── budget.odt
└── tutorials
    └── installarch.md
~~~

I wanted to add `schemas` for directory layouts, and pc parts and such.

~~~
├── schemas
│   ├── directories.yaml
│   ├── pc.yaml
│   └── websites.yaml
~~~

Here's a layout generated by ChatGPT, that has a different spin on it. I'll put it here for some reference:

~~~
~/docs/
├── notes/                  # Internal note-taking and knowledge capture
│   ├── daily/              # Daily logs, journals, thinking out loud
│   ├── dev/                # Dev-focused notes (debug, todos)
│   ├── meetings/           # Call notes, agendas, summaries
│   └── research/           # Notes on problems, experiments, design
├── logs/                   # Collected logs and execution records
│   ├── systems/            # System actions, boot logs, status captures
│   ├── builds/             # Logs from building, compiling, testing
│   ├── sessions/           # Shell session logs, CLI transcripts
│   └── ops/                # Operational logs from daemons, jobs, etc.
├── guides/                 # How-to documentation for staff or yourself
│   ├── tools/              # Docs on tools used (e.g., git, tmux, etc.)
│   ├── systems/            # PADS, Datasphere, and other internal modules
│   ├── workflows/          # Standard procedures (deploy, commit, backup)
│   └── onboarding/         # For new contributors or hires
├── specs/                  # Structured technical documentation
│   ├── api/                # API specs, interfaces
│   ├── schema/             # YAML/JSON schemas, data models
│   ├── modules/            # Specs for individual components/modules
│   └── architecture/       # Diagrams, high-level systems architecture
├── references/             # External or third-party info
│   ├── manpages/           # Exported or written-up man/info pages
│   ├── papers/             # Whitepapers, academic material
│   └── external/           # Blog posts, web pages, citations
├── drafts/                 # In-progress or unpublished content
│   ├── blog/               # Blog post drafts
│   ├── notes/              # Rough notes not yet sorted
│   └── projects/           # Early-stage plans, outlines
├── ops/                    # Operational documentation
│   ├── checklists/         # Deploy, backup, release, etc.
│   ├── incident-reports/   # Postmortems, error reports
│   └── runbooks/           # Scripts with human-readable instructions
└── business/               # Business-facing or high-level documents
    ├── plans/              # Roadmaps, strategy, quarterly plans
    ├── proposals/          # Specs for internal or client work
    ├── metrics/            # KPIs, graphs, performance summaries
    └── legal/              # Licenses, agreements, terms
~~~

No I have a good layout for a $HOME directory

~~~
├── archive                  # Archived data, old backups, or deprecated content
│   ├── etc                 # Archived system or configuration files
│   ├── os                  # Archived operating system-related files or logs
│   └── pads                # Archived data from the PADS system
├── docs                    # All documentation: business, technical, and personal
│   ├── companyA            # Formal documents for Company A
│   │   ├── chartofaccounts.pdf  # Accounting structure
│   │   ├── cover.pdf            # Document cover page
│   │   ├── structure.pdf        # Org or system structure
│   │   └── title.pdf            # Title or front page
│   ├── companyB            # Formal documents for Company B (same format)
│   ├── guides              # Instructional content and how-tos
│   │   ├── man             # Manpage-style guides
│   │   ├── tutorials       # Step-by-step walkthroughs
│   │   └── workflows       # Descriptions of operational/documented flows
│   ├── notes               # Informal documentation or personal notes
│   │   ├── notes.txt       # General notes
│   │   ├── pc_build.md     # PC build notes
│   │   └── projects.txt    # Project-related planning or logs
│   ├── paddocs             # PADDOCS project documentation (self-documented system)
│   │   ├── blogs           # Blog-style entries about PADDOCS
│   │   ├── index.md        # Main index file for PADDOCS docs
│   │   ├── manuals         # Core manual files
│   │   ├── print           # Exported documents in PDF format
│   │   ├── references      # Footnotes, glossary, LICENSE, and README
│   │   ├── templates       # HTML/CSS templates for rendering docs
│   │   └── web             # Generated HTML files for web publishing
│   ├── personal            # Personal documents (legal, financial, etc.)
│   │   ├── Army_Contract.pdf # Example personal/legal document
│   │   └── budget.odt        # Budget document
│   ├── schemas             # Structured config files (e.g. YAML format)
│   │   ├── directories.yaml  # Directory schema definition
│   │   ├── pc.yaml           # PC hardware or system configuration
│   │   └── websites.yaml     # Website structure/config metadata
│   └── tutorials           # Standalone tutorials
│       └── installarch.md  # Tutorial for Arch Linux installation
├── downloads               # Downloaded files (organized or to be sorted)
├── env                     # Python virtual environments
├── git                     # Local git repositories or mirrors
├── pads                   # Core of the PADS system
│   ├── bin                # Executables and CLI scripts for PADS
│   ├── handlers           # Modular handlers for runtime events
│   │   ├── daemons        # Background services or watchers
│   │   ├── models         # Model files (e.g., data templates or structures)
│   │   └── signals        # Signal traps and handler scripts
│   └── src                # Source code for the PADS framework
├── srv                     # Service configurations or self-hosted endpoints
├── templates               # Generic templates for documents, code, etc.
├── themes                  # Style themes for output (CSS, color schemes)
├── tmp                     # Temporary files and working space
├── utils                   # Utility scripts or helper tools
└── vault                   # Encrypted or sensitive files (e.g., credentials, keys)
~~~

I should make a YAML config for this to live in `schemas`.

After I moved everything around, and got everything set up, I've got this:

~~~
.
├── archive                          # Archived or backup data, mostly cold storage
│   ├── http                         # Saved HTTP data or site snapshots
│   ├── motoBackup                   # Backup from Motorola mobile device
│   ├── oldHome                      # Backup of an old home directory
│   ├── os                           # Archived OS files (ISOs, configs, etc.)
│   ├── pads                         # Archived data from the PADS system
│   └── scripts                      # Old or unused scripts retained for reference

├── docs                             # Centralized documentation repository
│   ├── armyglass                    # Military-related documents or case studies
│   ├── companyA                     # Business documents for Company A
│   ├── companyB                     # Business documents for Company B
│   ├── guides                       # Guides, how-tos, and manpage-style docs
│   ├── notes                        # General and project notes
│   ├── paddocs                      # Documentation system for PADS and related tools
│   ├── personal                     # Personal paperwork, contracts, and budgets
│   ├── schemas                      # YAML/JSON schema files (e.g., configs, structure)
│   └── tutorials                    # Educational content and walkthroughs

├── downloads                        # Auto-populated or manually organized downloads

├── env                              # Python virtual environments
│   └── flask                        # Flask-specific virtual environment

├── git                              # Git repositories (clones, mirrors, dev copies)
│   ├── bashville                   # Bash scripting projects or utilities
│   ├── datasphere                  # Datasphere repository
│   ├── interlink                   # Interlink repository
│   └── pads.repo                   # Main PADS repository

├── pads                             # Main source tree for the PADS system
│   ├── bin                         # Executable scripts related to PADS
│   ├── handlers                    # Event handlers, daemons, and signal traps
│   └── src                         # Core source code for PADS modules

├── srv                              # Services and network-shared assets
│   ├── share                       # Shared files (e.g., LAN-accessible content)
│   └── x                           # Experimental or transient service data

├── templates                        # Template files for docs, code, or content generation
│   ├── bash.sh                     # Shell script boilerplate
│   ├── blog.md                     # Markdown blog post template
│   ├── cover.odt                   # Document cover page template (LibreOffice)
│   ├── flask                       # Flask project templates
│   ├── game                        # Game project skeleton or assets
│   ├── main.less                   # LESS stylesheet base
│   ├── man.1.md                    # Markdown manpage template
│   ├── mkdocs.sh                   # Script to build MkDocs sites
│   ├── paddocs.sh                  # Script to generate PADDOCS site
│   └── python                      # Python boilerplate (scripts, modules, etc.)

├── themes                           # UI or document themes
│   ├── chocolate-rain              # Custom theme folder
│   ├── chocolate_rain.xml          # Theme metadata or config (XML)
│   └── theme_pads_theme.xml        # Theme definition specific to PADS

├── tmp                              # Temporary workspace (cleared or rotated manually)

├── utils                            # General-purpose utility scripts and tools
│   ├── archwiz                     # Arch Linux installer wizard
│   ├── conky                       # Conky system monitor configs/scripts
│   ├── datasphere                  # Utility tools for Datasphere
│   ├── interlink                   # Utility tools for Interlink
│   ├── mindmap                     # Mind-mapping tools or layouts
│   ├── traderJoes                  # Project or script related to Trader Joe’s data
│   └── tux                         # Tux-related utilities or branding assets

└── vault                            # Encrypted or sensitive data
    ├── githubkey.txt               # GitHub SSH or API key (consider encrypting)
    ├── hosts                       # Custom `/etc/hosts` equivalent or network configs
    └── pc_req.txt                  # System or project requirements (e.g., specs)

~~~

I made a schema in markdown and I formatted a YAML schema like this

~~~ yaml
home:
archives:
  - description:
  - dirs:
  - path:
~~~

---

## Day 2
*2025-4-18*

I want to organize my local websites to source templates and static files from one directory. Originally, I would be organizing my project like this:

  ~~~
  /srv/http/webproject/
  ├── webproject # Virtual Env
  ├── __init__.py
  ├── __main__.py
  ├── nginx.conf
  ├── __pycache__
  ├── requirements.txt
  ├── run
  ├── static
  ├── templates
  ├── uwsgi.ini
  └── views.py
  ~~~
  
So I would have the Virtual Env, Requirements, ENV VARS, Templates, and Static files all in the project. That's fine. But I'm always using the same templates, and when I want to see a different style i would have to load the entire Flask Project to see it. If I could switch between each style (or layout), in a testing environment that would be easier. I can use the directory to build on templates for documentation as well. Because technical documentation obviously has a different layout then a blog, or a catalog of items for sale. They serve different purposes but could be all in one project, or seperate project, or seperate repositories, or you could build a github repo and just source the URL instead of the absolute or relative path.

So I do have it narrowed down to this:

  ~~~
  /srv/http/
  ├── share
  │   ├── static
  │   └── templates
  └── x
      ├── __init__.py
      ├── __main__.py
      ├── nginx.conf
      ├── uwsgi.ini
      └── views.py

  ../env
  └── flask
      ├── bin
      ├── include
      ├── lib
      ├── lib64 -> lib
      ├── pyvenv.cfg
      └── share
      ├── requirements.txt
  ~~~

So all I did was move all templates, and static files to `share/{static,templates}` the Virtual Env goes to a different directory on its own to manage that, along with requirements.txt for said env. All configs can go into it's own directory somewhere as well. Usually the `activate` file, or a `config.py` file in the `share` directory, that's just listing the ENV VARS, so that's taken care of.

The project would have to be recompiled for github, but I'll have to do that anyway. But also, I've found that most of my projects I'm just working on internally, doing testing, and I'm not hosting the online. If they're on github they would be individual projects anyway. If it's more then a static site it won't be hosted on github. If it's a repository for downloading code, it's not gonna need a whole website, flask framework and static files anyway. So I think just that would solve most of my use cases. I can start to narrow down organizing docs, compared to a repo, compared to an ecommerce website, etc. Like, I have this text file saved in my srv dir, but I have paddocs saved in the paddocs dir. I need to make sure to organize the docs vs blog vs code vs web project.

---

# Closing
This wasn't anything difficult, it's just something I can't stop changing. So now I have a layout with my thoughts, and hopefully moving forward this won't be a thing anymore. I bet you $20 there will be a part 2 next week though.

---

# Index

- [Motivation](#motivation)
- [Thought Process](#thought-process)
    - [Day 1](#day-1)
    - [Day 2](#day-2)
    - [Day 3](#day-3)
    - [Day 4](#day-4)
    - [Day 5](#day-5)
- [Closing](#closing)

# Works Sited

 - [website]("www.google.com")

 [1]: (www.google.com)
