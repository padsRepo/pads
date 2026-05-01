# Automated Self-Documenting Code 

> “I couldn’t tell you in any detail how my computer works. I use it with a layer of automation.”   
>    — Conrad Wolfram

---

## Summary

To make a simple self documenting code concept.

## Motivation

After using mkdocs, and pandocs, there were issues with expansion, repetition, and confusion using the templates and plugins. They seemed to add unneccessary bulk to each project.

I like the direction of mkdocs, but I want the docs to generate for texinfo, groff, html, and a README for github. It seems overly complicating to me to use mkdocs, because it only wants to generate to html, to use like a wiki, as opposed to an info page, a man page, html, and a readme. pandoc on the otherhand will, but does not have a self-documenting code concept. These also depend on a lot of YAML files, and creating extra directories for the webpage, and self generating code, and you still need a source doc to generate from. I want it all to generate from the actual file with the code.

I think it would be simple enough to make my own self-documenting code using the same concept. Make headers in the file you're coding in, search for, and replace those headers in a markdown template that's generated from the paddocs code. Then you can use pandoc to parse the file to texi, groff, etc. You can still use mkdocs to deploy to github pages as well, just dont use the self generating concept. or make your own deployment to github pages, or the github wiki.

---

## Key Points

- Documentation generates from code
- Technical Reports generate into compendium structure
- Generating a HTML, PDF, man, info, or Markdown format
- [AST](https://docs.python.org/3/library/ast.html) (Abstract Syntax Tree)
- Using headers with `sed` to search and replace text
- Using STDOUT to print to a file in a directory.

---

## Definitions / Concepts

| Term         | Definition                          |
|--------------|-------------------------------------|
| Concept 1    | Short explanation here              |
| Concept 2    | Another explanation here            |

### Shell Tags

|Beginning Tag|Ending Tag|Description|
|-|-|-|
|title| |For Title|
|subtitle| |Description|
|brief| |Description|
|desc| |Description|
|author| |Description|
|email| |Description|
|created| |Description|
|repoURL| |Description|
|docsURL| |Description|
|blogURL| |Description|
|version| |Description|
|copyright|end copyright|Description|
|lic| |Description|
|synopsis| |Description|
|syntax| |Description|
|usageOpts| |(This is generated from the `usage()` function)|
|exit|end exit| |
|env|end env| |
|file|end file| |
|history|end history| |
|note|end note| |
|example|end example| |
|seealso| | |
|sourcecode| | |
|readme|end readme| |
|modules|end modules| |
|api|end api| |
|advanced|end advanced| | 
|troubleshoot|end troubleshoot| |
|contributing|end contributing| |

### Python Tags
|Dunder|Description|
|-|-|
|\_\_doc__| |
|\_\_version__| |
|\_\_author__| |
|\_\_date__| |
|\_\_updated__| |
|\_\_copyright__| |
|\_\_license__| |
|\_\_email__| |
|\_\_status__| |
|\_\_description__| |

---

## Detailed Notes

### Section 1

<details>
<summary>Details</summary>
#### Project Organization {#self-gen-org}
[\<next>](#self-gen-bash)

*2025-04-10*

I want to change the paddocs.sh script into a command, and I want to start adding templates I can use to convert it to html, man, info, pdf. I should include a template for a blog.

The command is comming along well. I can't decide how to set up flags for how you want the code to generate. Either wiki or manpage, or pdf, etc. What I have so far is this:

  ~~~bash
  while getopts ${OPTSTRING} mod; do
    case ${mod} in
      c) cmd=${OPTARG};;
      l) lang=${OPTARG};;
      v) echo "${version}"; exit;;
      h) usage; exit;;
      ?) echo " * pads -h for help"; exit 2;;
      *) echo "K18 Error"; exit 2;;
    esac
  done
  . "${base_dir}/src/paddocs/docGen.sh"
  genLicense
  genREADME
  genWiki
  genWikiHome
  genSrc
  ~~~
  
But surely you wouldn't want to run every function every time?

I decided to do this for now: 

  ~~~bash
  while getopts ${OPTSTRING} mod; do
    case ${mod} in
      c) cmd=${OPTARG};;
      l) lang=${OPTARG};;
      n) html=genHTML;;
      m) license=genLicense;;
      r) readme=genREADME;;
      w) wiki=genWiki;;
      x) wikiHome=genWikiHome;;
      s) src=genSrc;;
      v) echo "${version}"; exit;;
      h) usage; exit;;
      ?) echo " * pads -h for help"; exit 2;;
      *) echo "K18 Error"; exit 2;;
    esac
  done
  #[[ $# -eq 0 ]] && manual && exit
  echo ${cmd:-"*"} ${lang:-"bash"}
  . "${base_dir}/src/paddocs/docGen.sh"
  $license
  $readme
  $wiki
  $wikiHome
  $src
  $html
  ~~~

I can think about it more later. I might need to use long options for this one. So far this is a good layout
I added these extra switches so that it could make the templates more clean:

  ~~~bash
  [[ -n $status ]] && stat="Exit Status\n|Code|Status|\n|-----|-----|\n$status\n"
  [[ -n $repoURL ]] && repo="Repository: $repoURL\n"
  [[ -n $blogURL ]] && blog="Blog: $blogURL\n"
  [[ -n $author ]] && auth="Author\n$author\n"
  [[ -n $version ]] && ver="Version\n$version\n"
  [[ -n $copyright ]] && copy="Copyright\n$copyright\n"
  [[ -n $lic ]] && licl="License\n$lic\n"
  [[ -n $envvars ]] && env="Environment Variables\n|Key|Value|\n|-----|-----|\n$envvars\n"
  [[ -n $dirs ]] && fdir="Files/Directories\n|Path|Description|\n|-----|-----|\n$dirs\n"
  [[ -n $history ]] && hist="History\n$history\n"
  [[ -n $note ]] && notes="Notes\n$note\n"
  [[ -n $example ]] && ex="Examples\n$example\n"
  [[ -n $seealso ]] && see="See Also\n$seealso\n"
  [[ -n $quickstart ]] && quickie="Setup\n$quickstart\n"
  [[ -n $synopsis || -n $syntax || -n $usageOpts ]] && usage="Usage\n~~~$lang\n  $synopsis\n  $syntax\n$usageOpts\n~~~\n\n"
  ~~~
  
I made this function to generate a man page:

  ~~~bash
  genMan(){
    printf \
  "
  ---
  title: $title
  section: 1
  header: Man Page
  footer: $cmd $version
  date: $created
  ---

  # NAME
  $title $brief

  # SYNOPSIS
  $synopsis
  $syntax

  # DESCRIPTION
  $desc

  #OPTIONS
  $usageOpts

  # EXAMPLES
  $example

  # EXIT STATUS
  |Code|Status|\n|-----|-----|\n$status\n

  # NOTES
  $note

  # AUTHORS
  $author

  # REPORTING BUGS
  $email

  # COPYRIGHT
  $copyright

  # SEE ALSO
  $seealso
  " > "$save_dir/$cmd.1.md"
    [[ $? -eq 0 ]] && printf " :: Generated: $cmd.1\n"
    pandoc "$save_dir/$cmd.1.md" -s -t man -o "$save_dir/$cmd.1"
    gzip -fv $save_dir/$cmd.1
  }
  ~~~
  
First off it's great, but I notice that groff doesn't play well with the `<>` or any special char (like what generates for the synopsis). I'll have to think of a way to escape those if needed.

So I played with it for about 2 seconds, till I remembered this generates in Markdown so just indent a little and it'll treat it as a code block instead and escape the special characters:

  ~~~bash
  # SYNOPSIS
    $synopsis
    $syntax
  ~~~
  
Easy. Remember, it formats exactly like Markdown, so it'll mimmic it, so when in doubt resort to Markdown format.  

---

*2025-04-12*

I want to think about adding an info page, but I might put that off for now. I don't think I have much more to add with an info page except that it's in the terminal, and it's more interactive then a man page. But my commands aren't so complex that they need a full info page, most of the information is good enough for a man page, or a simple `-h` flag. Having it online helps, because I can look up infomation on my phone if all I have is a terminal (no GUI, or web browser on the machine). But the info page I wanted to use as more of a comprehensive guid to all of it, including tutorials, like installing arch, setting up a website, etc. But if I'm stuck in a terminal, I use my phone because I wouldn't want to have to search the info page for step one, then close it, do the step, open it back up, search for step two, close it, do the step, open it back up, search for step three, etc. So really a PDF I can print out would be more handy, as opposed to more repetitive terminal information. But I do like me a good info page.

---

*2025-04-20*

I put this down for a few days to move around some. I've been thinking of how to convert to pdf. It looks like using this as a header, and using this as a command to generate it does the trick. this enables world wrap on long lines of code block so they don't run off the page:

```
---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
---

pandoc --toc --pdf-engine=xelatex --eol=lf git/datasphere/index.md -o ./index.pdf
```

This generates a nice looking PDF you can print out. It'll also still render to HTML Nicely.

I really need to think about how to organize this. If it generates source docs from one MD page. I need a directory to organize each commands docs into, then copied to the repository, then printed into a book format. I need a seperate directory for the blog which could be organized like a website, or simple MD. Each tutorial should be it's own page, each command should be it's own page so that if things change I only have to print that one page, or change, rather than 26 pages of docs. If I want to use custom templates I need a directory for those as well (e.g jez.html, jez.css). Maybe a layout like this:

```
└── docs
    ├── companyA
    │   ├── cover.png
    │   ├── lic.md
    │   ├── plan.txt
    │   └── productflow.png
    ├── companyB
    │   ├── cover.png
    │   ├── lic.md
    │   ├── plan.txt
    │   └── productflow.png
    ├── notes
    └── paddocs
        ├── proj1
        │   ├── blog
        │   ├── cmd.1.md
        │   ├── cmd.html
        │   ├── cmd.md
        │   ├── cmd.pdf
        │   ├── LICENSE.md
        │   ├── README.md
        │   └── wiki
        ├── proj2
        │   ├── blog
        │   ├── cmd.1.md
        │   ├── cmd.html
        │   ├── cmd.md
        │   ├── cmd.pdf
        │   ├── LICENSE.md
        │   ├── README.md
        │   └── wiki
        ├── proj3
        │   ├── blog
        │   ├── cmd.1.md
        │   ├── cmd.html
        │   ├── cmd.md
        │   ├── cmd.pdf
        │   ├── LICENSE.md
        │   ├── README.md
        │   └── wiki
        └── templates
```

I can use my regular old `Documents` directory to organize the documents. Each project might have it's own code behind it, but we document it in one source file, and save it to multiple formats that can be used however from there. Company A might have a chart of accounts, and you might want to list it in a file that outlines all that. But the SQL for it goes with the code, not the docs. So when we need to access the information later on, we can use the man pages, the wiki, the printed form, and the blog just uses words to describe my thoughts about it. 

---

*2025-05-12*

So I'm coming back to revisit this, although I have a late start, it's 1630 hrs. and I have to be at work at 1800 hrs. I still need to build self-documenting code for python modules. I'm specifically saying python, because I'm a python developer, and not a Ruby developer. If I translate this code to Ruby, it would be Ruby. But it's not, it's python.

I should add that in the past week I wrote another blog on [directory management](directory_management.md), in which I restructed my docs directory to reflect this:

~~~bash
/home/$USER/docs/paddocs/
├── blogs
│   ├── adventures_with_chatgpt.md
│   ├── directory_management.md
│   ├── index.md
│   ├── llm.md
│   ├── project_paddocs.md
│   └── rpi3.md
├── index.md
├── manuals
│   ├── index.md
│   ├── paddocs.1.md
│   ├── paddocs.md
│   ├── pads.1.md
│   ├── pads.md
│   ├── proj.1.md
│   ├── proj.md
│   ├── sys.1.md
│   ├── sys.md
│   ├── tools.1.md
│   └── tools.md
├── print
│   ├── cover.odt
│   ├── installingArch.pdf
│   ├── maincover.odt
│   ├── paddocs.pdf
│   ├── padsguide.pdf
│   ├── pads.pdf
│   ├── proj.pdf
│   ├── sys.pdf
│   └── tools.pdf
├── references
│   ├── footnotes.md
│   ├── glossary.md
│   ├── LICENSE.md
│   └── README.md
├── templates
│   ├── jez.css
│   └── jez.html
├── tutorials
│   ├── de_wm.md
│   ├── index.md
│   └── installingarch.md
└── web
    ├── index.html
    ├── paddocs.html
    ├── pads.html
    ├── proj.html
    ├── sys.html
    └── tools.html
~~~

*2025-05-14*

Trying to find where I left off yesterday. I found a pretty big bug in the script:

~~~bash
$ paddocs -c bash
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
cat: /home/$USER/pads/bin/: Is a directory
#
# /etc/bash.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Prevent doublesourcing
if [[ -z "${BASHRCSOURCED}" ]] ; then
  BASHRCSOURCED="Y"
  # the check is bash's default value
  [[ "$PS1" = '\s-\v\$ ' ]] && PS1='[\u@\h \W]\$ '
  case ${TERM} in
    Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*)
      PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
      ;;
    screen*)
      PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
      ;;
  esac
fi

if [[ -r /usr/share/bash-completion/bash_completion ]]; then
  . /usr/share/bash-completion/bash_completion
fi
#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
#[[ $- == *i* ]] && source /usr/share/blesh/ble.sh
[  0 󰯰     interlink ] $ paddocs -c python -l python
paddocs -c python -l python
promptCommand1
[ user@pc ] $ ls
ls
promptCommand1
[ user@pc ] $ pwd
pwd
promptCommand1
[ user@pc ] $ clear
clear
promptCommand1
[ user@pc ] $
~~~

For some reason it's printing out the `bash.bashrc` all the the source files with it. This is probably a security issue.

*2025-05-28*

I've been spending the past few days trying to figure out a layout for a compendium. I found some good references.
  
```plaintext
~/docs/paddocs
├── assets
│   ├── code
│   ├── data
│   ├── diagrams
│   │   ├── bizStructure.png
│   │   ├── dirStructure.md
│   │   └── dirStructure.png
│   ├── images
│   │   └── ai-wormhole4.png
│   └── schemas
│       ├── bizReport.md
│       ├── bizStructure.odg
│       ├── blog.md
│       ├── cover.md
│       ├── dirStructure.odg
│       ├── metadata.yaml
│       └── techReport.md
├── config
│   ├── ieee.csl
│   ├── man.1
│   ├── template.html
│   ├── template.md
│   └── template.pdf
├── includes
│   ├── footer.md
│   ├── header.md
│   ├── reference.bib
│   └── todo.md
├── manuscript
│   ├── 00-front
│   │   ├── 00-copyright.md
│   │   ├── 01-revisions.md
│   │   ├── 02-preface.md
│   │   ├── 03-howto.md
│   │   ├── 04-structure.md
│   │   └── 05-roadmap.md
│   ├── 10-docs
│   │   ├── 00-cover.md
│   │   ├── interlink
│   │   │   └── 00-report.md
│   │   ├── metadata.yaml
│   │   └── pads
│   │       ├── 00-report.md
│   │       ├── paddocs.md
│   │       ├── pads.md
│   │       ├── proj.md
│   │       ├── sys.md
│   │       └── tools.md
│   ├── 11-manual
│   │   ├── 00-cover.md
│   │   ├── paddocs.md
│   │   ├── pads.md
│   │   ├── proj.md
│   │   ├── sys.md
│   │   └── tools.md
│   ├── 12-business
│   │   ├── 00-cover.md
│   │   ├── armyglass
│   │   │   ├── 00-report.md
│   │   │   └── 01-chartofaccounts.md
│   │   ├── metadata.yaml
│   │   └── theFshack
│   │       └── 00-report.md
│   ├── 17-tenants
│   │   └── Tenant A
│   │       ├── 00-cover.md
│   │       └── 10-menorandum.md
│   ├── 18-tutorials
│   │   ├── 00-cover.md
│   │   ├── 01-01-installingarch.md
│   │   └── 01-02-de_wm.md
│   ├── 19-blog
│   │   ├── 00-cover.md
│   │   ├── adventures_with_chatgpt.md
│   │   ├── directory_management.md
│   │   ├── llm.md
│   │   ├── project_paddocs.md
│   │   └── rpi3.md
│   └── 20-back
│       ├── a-glossary.md
│       ├── b-references.md
│       └── z-index.md
├── output
│   ├── chapters
│   │   ├── pads.html
│   │   └── pads.pdf
│   ├── compendium.html
│   ├── compendium.md
│   ├── compendium.pdf
│   └── sections
│       ├── docs.html
│       └── docs.pdf
├── metadata.yaml
└── README.md
```

I need to do a little more work on the `assets/`, `config/`, `includes/`, and maybe the `metadata.yaml`. I was also considering adding a spot to keep track of notes for things, and mermaid charts. But I'll have to work to that. It will also print out just a specific chapter, section, or the entire compendium to the `output/` directory. I changed around the `paddocs` logic to handle this directory structure, and added a funtion to build the directory from scratch. I would like to add functions to build the metadata, templates, and again, mermaid charts from scratch. I can always add more headers as I need to. I still need it to generate code from python, and set up a `.gitignore`. This is all just setting up the book. So this is where a good road map, and todo will do good.

#### Bash Generation {#self-gen-bash}
[\<prev>](#self-gen-org) [\<next>](#self-gen-python)

*2025-04-08*

Using headers makes the string more "clean" for example:

  1. Searching for a variable `author` in a file named `script.sh` adds the quotes:
  
      --> script.sh
      
      ~~~bash
        author=$(cat ~/pads/bin/${1} | grep "author=" | sed s/"author="//g)
        sed  -e "/## author/a$author" template.md > $1.md
      ~~~
        
      *Output:
      
      ~~~
        ## author
        "Joe Corso"
      ~~~
        
  2. Searching for a header `author` in a file name `script.sh` has no quotes:
  
      -->script.sh
      
      ~~~bash
        author=$(cat ~/pads/bin/${1} | grep "## author" | sed s/"## author"//g)
        sed  -e "/## author/a$author" template.md > $1.md
      ~~~
        
      *Output:
      
      ~~~
        ## author
        Joe Corso
      ~~~
        
Using `##` makes sense because they are considered comments and will not be parsed, but as the reader you will see the `##` and know it's a header.

The next task was searching for a string of text between two patterns. Something like this: [1][1]
    
```bash
    $ usageOpts=$($1 -h | sed -n '/Usage:/,/Ex:/{//!p}')

    *Output:
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
```

Then combine it into a template. Something like this:

```bash
  $ template.md
   
    # title
    ## subtitle
    ### Description
    ### Author
    ### Version
    ### Copyright
```
```bash
  $ script.sh

    sed -e "s/title/$title/g" -e "/### Author/a\ \n$author\n" -e "/### Version/a\ \n$version\n" -e "/## Usage/a\ \n$usageOpts" template.md > $1.md
```
The issue I'm having with following this process is that the sed nested within the sed is finding the first dash (e.g -b) and trying to interpret it as a command, and of course failing. It may be easier to just use stdout to build the template as it goes. Something like this:
```bash
  $ script.sh

   printf "# Usage\n  $usageOpts" > $1.md
```

---

*2025-04-09*

I was thinking I would just use stdout to print to a markdown file. It would be easier than trying to get this nested sed to work. Plus I won't have to make sure to carry around a template, because the code will generate the template. So let's go with that, and see where the next hiccup happens. 

I've spent the majority of the day trying to decide how much of the docs should generate from comments, and what should generate from code. For example, it makes sense to make comments at the top of the script to include creation date, author, copyright, version, and description of the script. But it also makes sense to just type `<cmd> -h` for a help, or `<cmd> -v` for the version. There would be excessive overhead to have to:

~~~bash
    $ version=$(cat "$file" | grep "## version" | sed s/"## version "//g)
~~~

As opposed to:

~~~bash
    $ version=$($cmd -v)
~~~
  
Some things would make sense to have as a header, (e.g copyright, license, creation date, long description, tutorial, examples, exit status)
Some things are already generated within the code, (e.g usage, version, syntax, synopsis, optstring).
For a section of the docs, that does not logically make sense to be the code, it would be easier to include tags like within html, so that you know to search for text within a pattern, and print that text as a string of characters. The easiest way to do that is with obvious, human-readable tags. For example:

~~~bash
    ## desc
    ## This is the description
    ## for your really awesome
    ## program you spent hours
    ## asking chatGPT how
    ## to write.
    ## end desc
~~~
  
You can see it relatively similar to texinfo in that it has an obvious beginning to the description, and an obvious end. Everything in between will be printed, regardless of the number of lines or the formatting. Notice that each line start with `## <tag>` and with blocks would end with `## end <tag>` to make it easy to search for within a text document. The difference from html is that html uses: <tag></tag> format, and I've found that using the special characters is sedistic, because you have to string together more hyrogliphic code to escape those special characters. This issuse with special characters seems like it's going to come up more often considering that just with the sed nested sed it was having the same issue.
Anyway, if we choose simple header tags, then a simple sed can be used: 

~~~bash
    $ desc=$(cat "$file" | sed -n "/## desc/,/## end desc/{//!p}" | sed s/"## //g")
~~~

We can keep the `## ` on each line so that we can simultaneously run the command without errors, because the computer will consider those comments and not be parsed. Then just strip it all off to have a block of plain text. Trust me it's easier than using `sed` to search and replace complex patterns.

The next task was applying a nice looking template. This is where we can still use `pandoc` to generate the markdown file into nice looking html. I took some time to look around on github for an open source template to start with, and I found this: https://jez.io/pandoc-markdown-css-theme/

I would like to take time to come back to this, and create my own template (maybe incorporate it into templetons templates). But for now, I'm using the ones from above, and giving credit to the creator; until I can make my own. All I need for now is the format, the code blocks, and a nav. Pandoc can generate all of that execept the css and html. I'll use this command to generate the html:

~~~bash
    $ pandoc -s --toc --number-sections --highlight-style=pygments -c jez.css --template jez.html --metadata pagetitle="${cmd}" pads.md -o ${cmd}.html
~~~

That command alone will generate the table of contents(nav), numbered sections, the css template, the html template, a title, the input file(the self generated one), and an output file.
I think in the future I would make the html template with all the style and js on the same page so I don't have to package an entire library as a template that would have to piggyback off of each project. Just make one template with all the html, css, and js inline, then host on the github project which has the self generating code, then you can just bootstrap the template with https://github.com/my/pandoc/template.git. Easy. That part's done.

Next was the things like the exit status or env vars, and how to render that. So this is where the start and end tags win again. In your script all you have to do is place this somewhere in the file:

~~~bash
    ## exit 
    ## 0 | Success
    ## 1 | Failure
    ## 127 | K18
    ## 130 | Ctl+C
    ## end exit
~~~

The markdown format for a table is like this:

~~~bash
  | Syntax | Description |
  | ----------- | ----------- |
  | Header | Title |
  | Paragraph | Text | 
~~~

Notice that you need the pipe (`|`) in between so that it seperates it into the proper columns. So for this we would need sed again. We would need to find the text between the start and end tags, strip off the extra pound symbols `## ` and insert a pipe between the first whitespace. That last part gives me problems. If you do something like this:

~~~bash
  $ cat ~/pads/bin/pads | grep "## exit" | sed s/"## exit "//g | sed s/""/" | "/g
~~~

You get:
  
~~~bash
    $ sed: -e expression #1, char 0: no previous regular expression
~~~
  
But if I wrap it in a start and end tag, then write the pipe manually in between, we can do something like this:

~~~bash
  status=$(cat "$file" | sed -n "/## exit/,/## end exit/{//!p}" | sed s/"## //g")
  ## Exit Status\n
  |Code|Status|
  |-----|-----|
  $status
~~~
  
Then the pipe is already there, and markdown assumes it's for the table. This renders the table properly, and it's easier than getting into the weeds with `sed`. We can follow this same pattern for our ENV Vars, our FILES, DIRS, etc. Anything formatted in a texinfo file that would be a key:value pair.

Moving right into the ENV Vars. Do this:

  ~~~bash
  ## env 
  ## BROWSER | w3m
  ## PROMPT_COMMAND | prompt_command
  ## RANGER_LOAD_DEFAULT | false
  ## PATH | \$PATH:\$HOME/pads/bin
  ## end env
  ~~~

Notice the forward slash in front of the `$`. If you don't add the forward slash pandocs wont read it, and will render the table without them. They're important considering they, themselves, are Environment Variables.

I added another parameter ($2) so that we can tell the script how to label the code blocks for better syntax highlighting.
EX:

~~~bash
  lang=${2}
  ## Usage\n~~~$lang\n  $synopsis\n  $syntax\n$usageOpts\n~~~\n\n\
~~~

NOT:

~~~bash
  ## Usage\n~~~bash\n  $synopsis\n  $syntax\n$usageOpts\n~~~\n\n\
~~~

OR

~~~bash
  ## Usage\n~~~\n  $synopsis\n  $syntax\n$usageOpts\n~~~\n\n\
~~~

When it comes to documenting the directory structure that could also probably be automated using the `ls` command, and maybe `sed` to add a description for each directory. Maybe printed to a secondary, or tertiary file to be manipulated some how. For now I'll keep using the tags. Those are easy. I'm liking those more.

Next is the history, or updates, or whatever. That is easy too. Bring in the starting and ending tags, and add a dash to make a list. Markdown automatically reads it as a list and make a nice bullet style list. Make it however you would to format in markdown and it'll format like that.

For an example code block, it's the same and just as easy. Following the exact same styling here: https://www.markdownguide.org/extended-syntax/#definition-lists, we can just add the beginning and ending tags and style it the same way. For example:

  ~~~bash
  ## example
  ## `pads -Pfm *project*`
  ## : In this example we make and start a Flask project named `project`.
  ## end example
  ~~~
  
That's all there is to that part.

I added a quickstart block that will be rendered as a README.md file for github, etc. Just make it the same as a numbered list for markup. This is an example:

  ~~~bash
  ## quickstart
  ## 1) Download:
  ##   `git clone https://github.com/padsRepo/pads`
  ## 2) Install:
  ##   `makepkg -si`
  ## end quickstart
  ~~~
  
I added a few tags for URLs, and made a base directory so it would organize it into a book, and be ready for github.
I decided to start using the github wiki for the docs and the pages for the blog.

So basically the workflow would be to create the code with the tags. run the command. make the first wiki page, and clone it. then copy the files you want into the cloned directory. commit and push. i may not nee the readme and license for each project but i'll have the self generated code.
Then i'll need to add a printable format and a terminal format.

---

*2025-04-22*

I had forgotten about print the source code along with the docs. So I just threw in a spot for it above the "See Also" section. the first problem I'm having is that the computer is trying to parse the shebang line as a command. I can try to strip it with `sed`, but then it says "event not found". Like this:

  `cat pads/bin/pads | grep "#!"`
  
  *Output:
  
  `#!/bin/bash`
  
  OR:
  
  `cat pads/bin/pads | grep "#!" | sed s/"#!/bin/bash"//g`
  
  *Output:
  
  `bash: !/bin/bash: event not found`
  
  OR:
  
  `cat pads/bin/pads | grep "#!" | seds/"\#!/bin/bash"//g`
  
  *Output:
  
  `bash: !/bin/bash: event not found`
  
  OR:
  
  `cat pads/bin/pads | grep "#!" | sed s/"\#!"//g`
  
  *Output:
  
  `/bin/bash`
  
  AND:
  
  `paddocs -c pads -l bash -s`
  
  *Output
  
  `paddocs/docGen.sh: line 89: #!/bin/bash: No such file or directory`


So I though rather then to search for the pattern and replace it with blank, we could instead just strip off the first line entirely. The shebang will always be the first line, and it always starts with `#!`, so we know for documentation purposes we don't need it. So all we have to do is this:

  `cat pads/bin/pads | grep "#!" | sed -r s/.//g`
  
Ok. So I was wrong on that. It strips off the first line, for sure; but it also strips off everything after that too. So the output is just blank.

  `sed -r 's/^#!.{9}//' pads/bin/pads`

I got this together, which strips off just the first line. It bashically (the typo just coined a new word bashically. like when you explain things basically with bashisms.). Anyway, it basically just finds the `#!` and then 9 characters after that. Except that now I get the error:

  `paddocs/docGen.sh: line 89: ##: command not found`

It needs to escape the special characters and such. This is a lot harder than it should be. I've been working at this for about 3 hours now.
If you just run `printf "$source"` it works. But being run in the script gets the error above, which is the line that redirects to the MD file. Which leads me to believe that the redirection is making it want to run as a script. Except no other vars are being parsed that way.
I thought I would try: [2][2]

  `cat $file | grep -v "^#!"`
  
It still gets the same error as above. It just seems to want to keep parsing the `##` as a command for some reason. But they're just comments, and every other variable is being rendered as a string. It's only the variable for the source code that seems to want to run as a command for some reason. If I work around that some how, it just says `title: command not found`. So it's just going down the page.

I finally figured out what was going on. It's `printf`. It doesn't have anything to do with `sed` or `grep`. The proper syntax to escape the commands is this: [3][3]

  `printf "%s\n" "$var"`
  
That escapes it properly, but now since I'm using the `##` as the headers, markdown wants to render it as headers, and it's ruining the formatting.
So with some tinkering I came up with this:

  `printf -v printsource "Source Code\n  ~~~bash\n%s\n~~~\n" "${sourcecode}"`

That prints it properly as a string, in a code block with the proper formatting. Then the command is basically this:

~~~bash
genSrc(){  
  printf \
# %s
 "${printsource}" > "$save_dir/${cmd}.md"
  [[ $? -eq 0 ]] && printf " :: Generated: $cmd.md\n"
}
~~~
    
There it'll generate a code block for the source code.
I decided to strip off the text that generates the code, and just leave the actual code it takes up less space. I needed to strip off the `##` and the blank lines it left behind:

  `sed -e '/^#/d' -e '/^$/d' "$file"`
  
It's just my preference so it doesn't take up so much space. I don't care about the header for the self generating docs.
I should make a script that will generate examples and source code from the fuctions used in each command.

#### Python Generation {#self-gen-python}
[\<prev>](#self-gen-bash) [\<next>](#section-2-2)

*2025-05-12*

I started by googling `how to import a python module without running it`, and found [this blog](https://bobbyhadz.com/blog/dont-run-module-when-it-is-imported-in-python). It's really simple, just add the `if __name__` block. Like this:

~~~python
if __name__ == '__main__':
  print(__doc__)
else:
  import interlink
~~~

If you are importing the module; say within a `Flask` server, it'll import all the modules without getting an error for saying there no flask module. If you're importing it from the command line, python will set the `__name__` of `__init__` to `__main__`, and we can grab the `__doc__ string` `__version__` etc. Now how do we bring this into bash? Well from the terminal we can run a command like this:

~~~bash
x=$(python __init__.py); echo -e "$x \n"
~~~

If we can run the script from the terminal, we can add it to `paddocs`. This is also slightly different then adding `##` headers to the top of a file. Python already has [docstrings](https://peps.python.org/pep-0257/#what-is-a-docstring), and those are already really cool. So I don't want to reinvent the wheel for that. I want to use them, and extract them, and manipulate them. I'll spend some time tinkering with `grep` and `sed` and printing to an `MD` file. Before I get to that, I have to restructure my python libraries a little. The `if __name__ == __main__` block works fine, but if I were to try to import the Formulators docstring, I would come full circle to the same issue if importing the module, and running it, which would raise the error that there is no flask module. So we change it to import the everything, only when the function is being called. Using the `formulator.Generator` as an example:

~~~python
class Generator:
  '''
  The generator is the module used to generate your forms, reports,
queries, and anything DB related.

Let's say you want to generate a blog. Use the formulator.Generator to
make a query of your blog table from your SQL database. Create a
variable from it, and then using Jinja's Templating Engine with Flask,
we can manipulate the variable in an html template anyway we want.

Examples:

    from interlink import Generator
    @templetonBP.route('/forms/<db>/<page>', methods=['GET', 'POST'])  
    def generateForm(db, page):  
        gen = Generator(db, 'DB_USER', 'DB_PASS')  
        error, form, title = gen.generateForm(page)  
        return render_template('forms.html', error=error, form=form, title=title)
        

    from interlink import Generator
    @templetonBP.route('/reports/<db>/<page>')
    def generateReport(db, page):
      gen = Generator(db, 'DB_USER', 'DB_PASS')
      colName, colRow, error, title = gen.generateReport(page)
      return wrapper('reports.html', colName=colName, colRow=colRow, error=error, title=title)
      
    @viewsBP.route(/)
    def index():
      gen = i.Generator('DB', 'DB_USER', 'DB_PASS')
      nav = gen.generateNav()
      return render_template('index.html', nav=nav)
  '''
 
  def __init__(self, db, user, password):
    '''Initialize the Generator object.'''
    self.db = db
    self.user = user
    self.password = password
    
  def generateForm(self, table):
    '''
    Generate a form to enter data into the `table`
    
    Returns: 
      error (str): Success! Error!
      form (str): Success! 404 
      title (str): DB table name
    '''
--> from .logic import createForm
    error, form = createForm(self.db, self.user, self.password, table)
    title = table
    return error, form, title
~~~

Usually, I declare all of my imports at the top of the file. Now I'll declare my imports within the function. Notice under `generateForm` all I did was move the line `from .logic import createForm` from the top, to there. Then we can call the `__doc__` without running the command. So now in our `__init__.py` file we print all the variables we need to generate the documentation:

~~~python
  if __name__ == '__main__':
    from formulator import Generator as g
    print(__doc__, __version__, __author__, __date__, __updated__, g.__doc__, g.generateForm.__doc__)
~~~

---

*2025-05-13*

I've been trying to think of how I would want to organize the docstrings so they can make sense, like [google style guide](https://google.github.io/styleguide/pyguide.html). Or also [including python scripts in a bash script](https://unix.stackexchange.com/questions/184726/how-to-include-python-script-inside-a-bash-script), to be able to extract variables that can neatly placed wherever you want them to be. I was also thinking, assuming I'm using markdown, that the docstring can just be formatted for markdown anyway. If you follow googles styling guide it looks prettier in a terminal, or if you use pythons built in `help()` command. After looking around for a little bit, I found [this website](https://www.programiz.com/python-programming/docstrings), which lead me to [this link](https://stackoverflow.com/questions/3898572/what-is-the-standard-python-docstring-format) on the different methods of formatting your docstrings. I personally like google styling the best. But I still need a way to be able to use it in a template.

I looked [here](https://stackoverflow.com/questions/4257098/how-to-pass-variables-from-python-script-to-bash-script), and found this:

~~~bash
python b.py tempfile.txt
var=`cat tempfile.txt`
rm tempfile.txt
~~~

Then I tinkered with [this](https://unix.stackexchange.com/questions/184726/how-to-include-python-script-inside-a-bash-script):

~~~bash
#!/bin/bash

$ MYSTRING="Do something in bash"
$ echo $MYSTRING

$ python - << EOF
myPyString = "Do something on python"
print myPyString

EOF

$ echo "Back to bash"
~~~

I was mostly using DuckDuckGo, and not having much luck, so switched to google, and the [AI Overview](https://www.google.com/search?q=python+import+vars+into+bash&sca_esv=01731d022ec92237&source=hp&ei=QFcjaNjXHqKsptQPvq2NYA&iflsig=ACkRmUkAAAAAaCNlUCxjX3daumUkshscm4Fdlql3ERAu&ved=0ahUKEwjY9--Q1KCNAxUilokEHb5WAwwQ4dUDCBk&uact=5&oq=python+import+vars+into+bash&gs_lp=Egdnd3Mtd2l6IhxweXRob24gaW1wb3J0IHZhcnMgaW50byBiYXNoMgUQIRigATIFECEYoAEyBRAhGKABMgUQIRigATIFECEYoAEyBRAhGJ8FMgUQIRifBTIFECEYnwVIgl9QAFjdXHAAeACQAQCYAYABoAHHEqoBBDIzLjW4AQPIAQD4AQGYAhygAogTwgILEC4YgAQYsQMYgwHCAgsQLhiABBjRAxjHAcICBRAuGIAEwgIFEAAYgATCAg4QLhiABBixAxjRAxjHAcICCBAAGIAEGLEDwgILEC4YgAQYxwEYrwHCAggQLhiABBixA8ICCxAAGIAEGLEDGIMBwgILEAAYgAQYhgMYigXCAggQABiABBiiBMICBRAAGO8FwgIGEAAYFhgewgIIEAAYogQYiQWYAwCSBwQyMi42oAfnwgGyBwQyMi42uAeIEw&sclient=gws-wiz) gave me this:

~~~python
# python_script.py
variable1 = "hello"
variable2 = 123
print(f"export VAR1='{variable1}'")
print(f"export VAR2={variable2}")
~~~
~~~bash
#!/bin/bash
$ source <(python python_script.py)
$ echo "Variable 1: $VAR1"
$ echo "Variable 2: $VAR2"
~~~

I kinda like that, because, considering I want to use bash to parse the markdown formatting; being able to manipulate the data from bash scripts will be handy, because each class and function will have their own docstrings. This part of the layer has less to do with how to format the docstring, and more with manipulating the data how we want to. We could still just go ahead and format the docstrings to markdown, and just print to an `.md` file. We can still use the same recommended headers of other styles, but we would still have to write more code using `grep` or `sed` to extract the text as plain text, do any stripping etc, and still put it in the right spot on a markdown template. There aren't any rules that say you have to use the popular styles, it's just recommended, so that it's easier for someone else to understand. But I would think a style in markdown would be easy to understand, wouldn't it? That's the point right? It doesn't seem like using `help()` or `dir()` or `__doc__` doe any formatting *necessarily* so I won't worry about that.

I jumped the gun on that. When I mess with it, I get this:

~~~python
if __name__ == '__main__':
  from formulator import Generator as g
  x = g.__doc__
  print(f"export x='{x}'")
~~~

~~~bash
$ source <(python __init__.py)
bash: export: 'blog.': not a valid identifier
bash: export: 'formulator.Generator': not a valid identifier
make: *** No rule to make target 'a'.  Stop.
bash: db: No such file or directory
~~~

But instead, if I do:

~~~python
if __name__ == '__main__':
  from formulator import Generator as g
  print(g.__doc__)
~~~

Everything runs clean. So if the docstrings are just styled the same as Markdown, it might be easier. After looking at how `mkdocs` generates the `readthedocs` template, I think I could do the same thing. 
I've been having problems with this, in that I'm having problems with `sed`, and writing the docstring in all markdown just makes the `__doc__` object really messy. I revisited the `print(f"export x='{x}'")` command, and found that it wants to print literally in bash because of the single quotes. So I just switched them around, and now it runs fine.

I've been having a problem with importing the top level `__doc__` from the interlink module. Basically, if I run the following command, I can run it in bash, and it'll be fine.

~~~python
if __name__ == '__main__':
  from formulator import Generator as g
  print(f''' export generatorDocs="{g.__doc__}" ''')
~~~

~~~bash
$ source <(__init__.py)
$ echo -e "$generatorDocs \n"
~~~

**OUTPUT**

~~~
  The generator is the module used to generate your forms, reports,
queries, and anything DB related.

Let's say you want to generate a blog. Use the formulator.Generator to
make a query of your blog table from your SQL database. Create a
variable from it, and then using Jinja's Templating Engine with Flask,
we can manipulate the variable in an html template anyway we want.

Examples:

    from interlink import Generator
    @templetonBP.route('/forms/<db>/<page>', methods=['GET', 'POST'])
    def generateForm(db, page):
        gen = Generator(db, 'DB_USER', 'DB_PASS')
        error, form, title = gen.generateForm(page)
        return render_template('forms.html', error=error, form=form, title=title)


    from interlink import Generator
    @templetonBP.route('/reports/<db>/<page>')
    def generateReport(db, page):
      gen = Generator(db, 'DB_USER', 'DB_PASS')
      colName, colRow, error, title = gen.generateReport(page)
      return wrapper('reports.html', colName=colName, colRow=colRow, error=error, title=title)

    @viewsBP.route(/)
    def index():
      gen = i.Generator('DB', 'DB_USER', 'DB_PASS')
      nav = gen.generateNav()
      return render_template('index.html', nav=nav)
~~~

But if I add the `__doc__` from interlink, I get an error. 

~~~python
interlinkDocs = str(__doc__)
print(f'''\
  export generatorDocs="{g.__doc__}" \
  export interlinkDocs="{interlinkDocs}" \
''')
~~~

**OUTPUT**

~~~bash
bash: /dev/fd/63: line 251: syntax error near unexpected token '('
bash: /dev/fd/63: line 251: '        <a href="{{ url_for('/.index') }}">Index</a>'
~~~

I'm wondering if it's because the `Generator` is a class, and `interlink` is the `__init__.py` top level docstring.

I've been working on this all day, and I'm not getting any closer. Eventually I found a library called [shlex](https://docs.python.org/3/library/shlex.html). It's an external library, but it's as close as I can figure out right now.

So in the script if I do a command like `echo -e "$generatorDocs\n" | sed -e "1 i # formulator.Generator"`. I can insert a header on the first line. Or if I do `echo -e "$generatorDocs\n" | sed -e "s/Examples/# Examples/g"` I can turn the Examples block from google styling, and turn it into a markdown header. The next task is breaking up the docstring where there's chunks like this:

~~~
Modules:
  formulator: Form and Report Generator
  templeton: Template Generator
  safeHaven: Security Guard
  toolkit: Misc Tools

Classes:
  Generator: Forms
  DB: Connect to DB

Functions:  
  tempulator: templates
  tempulation: Custom Views
  honeypot: distraction
  backdoor: entry way
  login: check user
  site_map: site map for SEO
  url_not_found: 404 Error
  internal_error: 500 Error
  templetonBP: Templeton Templates
~~~

I found this for a good start. It wont be *the* answer though.

~~~bash
echo -e "$interlinkDocs" | sed -n '/^Modules:/,/^$/p'
~~~

I'll probably have to rework the `paddocs` command to fit python. I'm starting to get a brain fart. It's 2143 hrs. I started working today at around 0900 hrs.

*2025-05-14*
I'm thinking over how to generate the python docs, and after all that work I did yesterday I'm thinking about scrapping it. I like the code, and I think I'll save it somewhere for something later. But if you start from the beginning of a fresh project the workflow would be: start/make the project -> build the docs -> add the `if __name__` block and add all this extra boilerplate to it including an external lib:

~~~python
if __name__ == '__main__':
  import shlex
  from formulator import Generator as g
  from templeton import tempulator as t
  interlinkDocs = shlex.quote(__doc__.strip())
  print(f''' \
    export version="{__version__}" \
    export interlinkDocs={interlinkDocs} \
    export generatorDocs="{g.__doc__}" \
    export templetonDocs="{t.__doc__}" \
  ''')
else:
  *etc*
~~~

That would be a lot to add to every project, and a lot harder to piece together than simple headers (or a docstring in this case). If we print to the screen (like using `cat` in bash so much), we can just go back to using `grep` or `sed` like earlier, and we can stick to google style guide. So all we'll have to do is something like this instead:

~~~python
if __name__ == '__main__':
  from formulator import Generator as g
  print(__doc__)
  print(g.__doc__)
else:
  *etc*
~~~

If we follow this, we can probably reuse the same fuctions from bash as well, so that's a win. Since it follows along with this project this is the style that google uses:


   > The **Google Python Style Guide** for docstrings uses a **clean, readable structure** that's widely adopted for clarity and tooling  compatibility (e.g., with Sphinx using `napoleon`). Below is a complete format covering modules, classes, methods, and functions.
   > 
   > ---
   > 
   > 🧩 Google Style Docstring Format
   > 
   > 🔹 Module-Level Docstring
   > 
   > ```python
   > """
   > Short description of the module.
   > 
   > Longer description explaining the module’s purpose and usage,
   > including optional examples or references.
   > 
   > Modules:
   >  [Name](#link): Description
   > 
   > Classes:
   >   [ClassName](#link): Description
   > 
   > Functions:  
   >   [funcName](#link): Description
   >
   > Examples:
   >     foo = MyClass()
   >     foo.bar()
   > """
   > ```
   > 
   > ---
   > 
   > 🔹 Function/Method Docstring
   > 
   > ```python
   > def function_name(param1, param2="default"):
   >     """
   >     Summary line (brief description of what the function does).
   > 
   >     Longer description that can span multiple lines, describing
   >     the behavior, algorithm, or use case of the function.
   > 
   >     Args:
   >         param1 (int): Description of `param1`.
   >         param2 (str, optional): Description of `param2`. Defaults to "default".
   > 
   >     Returns:
   >         bool: Explanation of the return value.
   > 
   >     Raises:
   >         ValueError: If `param1` is negative.
   >         TypeError: If the types of inputs are incorrect.
   >     """
   > ```
   > 
   > ---
   > 
   > 🔹 Class Docstring
   > 
   > ```python
   > class MyClass:
   >     """
   >     Summary of what the class represents.
   > 
   >     Detailed explanation of what the class does, its intended use,
   >     and any implementation notes.
   > 
   >     Attributes:
   >         attr1 (str): Description of attr1.
   >         attr2 (int): Description of attr2.
   >     """
   > 
   >     def __init__(self, attr1, attr2):
   >         """
   >         Constructs all the necessary attributes for the object.
   > 
   >         Args:
   >             attr1 (str): Description of `attr1`.
   >             attr2 (int): Description of `attr2`.
   >         """
   > ```
   > 
   > ---
   > 
   > 🔹 Example with All Sections
   > 
   > ```python
   > def connect(host, port=3306, timeout=10):
   >     """
   >     Connects to a database.
   > 
   >     Attempts to establish a connection to the specified host and port.
   > 
   >     Args:
   >         host (str): The hostname or IP address.
   >         port (int, optional): The port number. Defaults to 3306.
   >         timeout (float, optional): Connection timeout in seconds. Defaults to 10.
   > 
   >     Returns:
   >         Connection: A live connection object.
   > 
   >     Raises:
   >         ConnectionError: If the connection cannot be established.
   >         TimeoutError: If the connection times out.
   > 
   >     Examples:
   >         >>> conn = connect("localhost")
   >         >>> conn.execute("SELECT * FROM users")
   >     """
   > ```
   > 
   > ---
   > 
   > ✅ Summary of Sections
   > 
   > | Section                  | Description                                 |
   > | ------------------------ | ------------------------------------------- |
   > | **Summary line**         | One-line description                        |
   > | **Extended description** | (optional) More context                     |
   > | **Args**                 | Each parameter: `name (type): description`  |
   > | **Returns**              | Type and what it returns                    |
   > | **Raises**               | Possible exceptions                         |
   > | **Examples**             | (optional) Usage example in `doctest` style |
   > 
   > ---

I'll have to make a `YAML` schema for this or something.

So moving back into the project, I still need to get these variables some how. If I do `version=$(python "$file" | grep "0.0.[0-9]")` or something I feel like that is going to be unreliable. What if it's `x.x.x.x`, or `x.x.x.x.xW02Y10`? I had an idea that might work better. If I do: `python __init__.py` it sources the file but does not carry along the variables. I would need to import it, but if I import it, it tries to actually run the package, which brings us back to the error of `no flask module found`. So let's change it so it say this:

~~~python
if __name__ == '__init__':
  pass
else:
~~~

Then for our script we can do:

~~~bash
python -c "import __init__; print(__init__.__version__)"
~~~

I think that might be ok. Let's charlie mike this project, and see what happens next. I'm still just having issues of things importing wrong, and trying to run things it shouldn't. I almost feel like I need to start from scratch, because the project itself might need some restructuring. I'm just at a serious roadblock with this part of the project.

---

*2025-05-15

Well yesterday was a huge waste of time. I messed with it for about 15 minutes before work and realized all I needed to do was this:

~~~python
version=$(python -c "from interlink.__init__ import __version__; print(__version__)")
~~~

---

*2025-05-16

I had to keep testing stuff. Nothing I was doing was working. I really want to try to find a way to work with this command `python -c "from __init__ import *; print(__version__)"`. It seems like if I just remove the `if __name__ == '__main__'` block, I can change it from this:

~~~python
if __name__ == '__main__':
  import formulator
  #print(__version__)
  #print(__doc__)
  #print(g.__doc__)
  print("init")
else:
  # formulator functions
  print(" * Loading Formulator...")
  from interlink.formulator import Generator

  # templeton functions
  print(" * Loading Templeton...")
  from interlink.templeton import tempulator
  from interlink.templeton.views import url_not_found, internal_error, templetonBP

  # safe haven functions
  print(" * Loading Safe Haven...")
  from interlink.safeHaven import honeypot, backdoor, login

  # toolkit functions
  print(" * Loading Toolkit...")
  from interlink.toolkit import DB, get_script_path, site_map

  print(f' * Interlink {__version__} is online')
~~~

To just this:

~~~python
import formulator
import templeton.views
import safeHaven
import toolkit
~~~

Maybe this will give better flexibility with the package as well, because from there you import each class or function your own. As opposed to my predefined import. When it get to `safeHaven`, I still get the error about Flask. But I'm thinking I could either nest that within the decorators, or just import it from the app. Because if you think about it, flask is loading from the app you're building first. So maybe it could pull it from there rather then importing within the module. If I just comment out the line for now it just goes down the list, getting another error:

~~~python
Traceback (most recent call last):
  File "<string>", line 1, in <module>
    from __init__ import *; print(__version__)
    ^^^^^^^^^^^^^^^^^^^^^^
  File "/home/frank/utils/interlink/src/interlink/__init__.py", line 288, in <module>
    import safeHaven
  File "/home/frank/utils/interlink/src/interlink/safeHaven/__init__.py", line 4, in <module>
    from flask import request, render_template, session, redirect, url_for
ModuleNotFoundError: No module named 'flask'
~~~

~~~python
Traceback (most recent call last):
  File "<string>", line 1, in <module>
    from __init__ import *; print(__version__)
    ^^^^^^^^^^^^^^^^^^^^^^
  File "/home/frank/utils/interlink/src/interlink/__init__.py", line 288, in <module>
    import safeHaven
  File "/home/frank/utils/interlink/src/interlink/safeHaven/__init__.py", line 5, in <module>
    from __init__ import app
ImportError: cannot import name 'app' from partially initialized module '__init__' (most likely due to a circular import) (/home/frank/utils/interlink/src/interlink/__init__.py)
[1] ERROR:pads.sig:err_script: paddocs.?.8:python -c "from __init__ import *; print(__version__)"
~~~

~~~python
Traceback (most recent call last):
  File "<string>", line 1, in <module>
    from __init__ import *; print(__version__)
    ^^^^^^^^^^^^^^^^^^^^^^
  File "/home/frank/utils/interlink/src/interlink/__init__.py", line 289, in <module>
    import toolkit
  File "/home/frank/utils/interlink/src/interlink/toolkit/__init__.py", line 4, in <module>
    from flask import url_for
ModuleNotFoundError: No module named 'flask'
[1] ERROR:pads.sig:err_script: paddocs.?.8:python -c "from __init__ import *; print(__version__)"
~~~

I might need to rework some of the actual library to be more prepared for this sort of stuff. When I was originally writing this library, I didn't know what self-documenting code was, and I didn't think I would need it in a terminal. But this part of the project is really throwing me for a loop.

I nested everything so that those modules giving me problems would only import within the function or class. 

---

*2025-05-17*

Let's recap a little.

If I do this, there's a lot of extra boilerplate for each project:

~~~python
  if __name__ == '__main__':
    from formulator import Generator as g
    print(__doc__, __version__, __author__, __date__, __updated__, g.__doc__, g.generateForm.__doc__)
~~~

Something like this might work, but for each project I would have to manuallly change the code for each project:

~~~python
# python_script.py
variable1 = "hello"
variable2 = 123
print(f"export VAR1='{variable1}'")
print(f"export VAR2={variable2}")
~~~
~~~bash
#!/bin/bash
$ source <(python python_script.py)
$ echo "Variable 1: $VAR1"
$ echo "Variable 2: $VAR2"
~~~

If we follow the Google style guide, we might be able to use this format. But considering each module has examples, and exit status', and such it would be hard to differentiate between one or the other:

~~~bash
modules=echo -e "$interlinkDocs" | sed -n '/^Modules:/,/^$/p'
~~~

There are a few slightly difference way we could run something like this:

~~~bash
version=python -c "import __init__; print(__init__.__version__)"
~~~

We could also print to a text file, then `source` the file in bash:

~~~python
  import formulator, templeton, safeHaven, toolkit
  tmpDir = '/tmp'
  print('Exporting vars to:', tmpDir)
  with open('/tmp/paddocs_python_vars.sh', 'w') as f:
    f.write(f'''
version="{__version__}"\n\
author="{__author__}"\n\
createDate="{__date__}"\n\
updateDate="{__updated__}"\n\
copyright="{__copyright__}"\n\
license="{__license__}"\n\
email="{__email__}"\n\
status="{__status__}"\n\
description="{__description__}"\n\
''')
    f.close()
  with open('/tmp/paddocs_python_docs.sh', 'w') as f:
    f.write(f''' {__doc__} ''')
    f.close()
~~~

~~~bash
$ python ${file}
$ . "/tmp/paddocs_python_vars.sh"
$ echo "${version}"
~~~

Or we can use the EOF. Just slightly different than this `version=python -c "import __init__; print(__init__.__version__)"`:

~~~bash
#!/bin/bash

$ MYSTRING="Do something in bash"
$ echo $MYSTRING

$ python - << EOF
myPyString = "Do something on python"
print myPyString

EOF

$ echo "Back to bash"
~~~

The thing with each of these, is that you have to be careful to only import dependencies from within the `function` or `class`, and you would have to manually change the names of the library in the code every time you start a new project. I kind of like the idea of using the styling, and `sed`.

I've been fiddling with stuff for a few more hours. I came across this that seems to work "well" but let's see. I've been let down before. Right now, I'm having a hard time trying to import the parent directory (i.e: `interlink.__init__`):

~~~python
__all__ = ['__init__', 'formulator', 'templeton', 'safeHaven', 'toolkit']
~~~

~~~bash
cd ${dir}
python ${file}

module=$(python -c '
import importlib
from __init__ import __all__
for name in __all__:
  module = importlib.import_module(f"{name}")
  print(f"{name}:\n{module.__doc__}\nSTOP")'
)

docs=$(python3 -c '
import ast
from __init__ import __all__
for x in __all__:
  print(x)
  with open(x + "/__init__.py") as f:
    tree = ast.parse(f.read())

  for node in tree.body:
    if isinstance(node, (ast.FunctionDef, ast.ClassDef)):
        name = node.name
        doc = ast.get_docstring(node)
        if doc:
            print(f"{name}: {doc}\n")
')
echo -e "${module}\n"
echo -e "${docs}\n"
~~~

I feel like I need a better testing environemt for this. I'll have to set up a python lib to just try this right, from the beginning.

*2025-07-15*

On *2025-06-19* I finished the python module. It was just a lot of fiddling with `ast` in python for a while. Eventually I came up with this:

```bash
parsePython(){
  # https://gabrielelanaro.github.io/blog/2014/12/12/extract-docstrings.html

  dir=$(find "$HOME/dev/" -type d -iname "$cmd")
  projDir=$(printf "$dir" | head -1)
  saveFile="${cmd}.md"
  saveDir=$(printf "$dir" | grep "10-docs")

  python -c "
import ast
import os

number = 10
projDir = '${projDir}'
projFile = '__init__.py'
saveFile = '${saveFile}'
saveDir = '${saveDir}'
savePath = f'{saveDir}/{number}-{saveFile}'

if os.path.exists(f'{saveDir}/{saveFile}'):
  os.remove(f'{saveDir}/{saveFile}')

with open(f'{projDir}/{projFile}') as f:
  tree = ast.parse(f.read())

for node in ast.walk(tree):
  if isinstance(node, ast.Assign):
    for target in node.targets:
      if isinstance(target, ast.Name) and target.id.startswith('__') and target.id.endswith('__'):
        try:
          value = ast.literal_eval(node.value)
        except:
          value = ''
        finally:
          print(target.id, '=', value)

for path, dirname, filename in os.walk(projDir):
  for x in filename:
    if x == '__init__.py':
      filename = f'{path}/{x}'

      ast_filename = filename
      with open(filename) as fd:
        module = ast.parse(fd.read())

      class_definitions = [node for node in module.body if isinstance(node, ast.ClassDef)]
      function_definitions = [node for node in module.body if isinstance(node, ast.FunctionDef)]
      if ast.get_docstring(module) is not None:
        open(f'{savePath}', 'w').write('\n' + '## ' + os.path.basename(path) + '\n' + ast.get_docstring(module) + '\n\n')
      for c in class_definitions:
        if ast.get_docstring(c) is not None:
          open(f'{savePath}', 'a').write('### ' + c.name + '\n' + ast.get_docstring(c) + '\n\n')
        for cFun in c.body:
          if isinstance(cFun, ast.FunctionDef):
            open(f'{savePath}', 'a').write('#### ' + cFun.name + '\n' + str(ast.get_docstring(cFun)) + '\n\n')
      for f in function_definitions:
        if ast.get_docstring(f) is not None:
          open(f'{savePath}', 'a').write('### ' + f.name + '\n' + ast.get_docstring(f) + '\n\n')
  number += 1
  "
  cd ${saveDir}
  # replace googlestyle docs with markdown links to each mod, class, or function.
  sed -E -e '/Modules:/,/^$/ {' -e '/Modules:/b' -e 's/([a-zA-Z0-9_]+):/[\1](#\L\1) | /g' -e '}' -e '/Classes:/,/^$/ {' -e '/Classes:/b' -e 's/([a-zA-Z0-9_]+):/[\1](#\L\1) | /g' -e '}' -e '/Functions:/,/^$/ {' -e '/Functions:/b' -e 's/([a-zA-Z0-9_]+):/| [\1](#\L\1) | /g' -e '}' -e '/Returns:/,/^$/ {' -e '/Returns:/b' -e 's/([a-zA-Z0-9_()]+):/\1 | /g' -e '}' 1*.md > file.txt
  # Style it for a table
  sed -i s/"Modules:"/"| Modules | Description |\n|-|-|"/g file.txt
  sed -i s/"Classes:"/"| Classes | Description |\n|-|-|"/g file.txt
  sed -i s/"Functions:"/"| Functions | Description |\n|-|-|"/g file.txt
  sed -i s/"Returns:"/"| Returns | Description |\n|-|-|"/g file.txt
  rm 1*.md
  mv file.txt 10-${cmd}.md
}
```

After that I generated templates to use as reports for everything I could think of. It's under `assets/schemas/`. I also cleaned up and refractored a lot of the code and added an http.server to watch in the browser. It's reflected in the source code, so I don't think I need to post it here. But it's all done ladies and gents!


**2025-08-20**
I need to take notes on some editing.

This was finding the dunders in the lib. 

```python
for node in ast.walk(tree):
  if isinstance(node, ast.Assign):
    for target in node.targets:
      if isinstance(target, ast.Name) and target.id.startswith('__') and target.id.endswith('__'):
        try:
          value = ast.literal_eval(node.value)
        except:
          value = ''
        finally:
          print(target.id, '=', value)
```

But I needed to print them in a better format. They needed to print to this, and it is not nested in the same for loop, so it was only finding the last dunder.

```python
if ast.get_docstring(module) is not None:
  open(f'{savePath}', 'w').write('\n' + '## ' + os.path.basename(path) + '\n' + ast.get_docstring(module) + '\n\n')
```

So by doing this we can manipulate the dunders better:

```python
dunders = [(target.id, ast.literal_eval(node.value)) 
for node in ast.walk(tree) 
if isinstance(node, ast.Assign) 
for target in node.targets 
if isinstance(target, ast.Name) and target.id.startswith('__') and target.id.endswith('__')
]
```


</details>

### Section 2

<details>
<summary>Details</summary>
- Add diagrams or examples if needed
- You can embed code or links
</details>

### Section 3

<details>
<summary>Details</summary>
- Add diagrams or examples if needed
- You can embed code or links
</details>

---

## Ideas / Questions

- What if...?
- How does this relate to...?
- Need to explore...

---

## Action Items / To-Dos

- [ ] Determine tags to use
- [ ] Build Binary File
- [ ] Build parser for each language
- [ ] Build structure for Book

---

## References

- [Link 1](https://example.com)
- Book: _Title_ by Author
- Article: "Title" (Date)

- [Print lines of a file between two matching patterns](https://unix.stackexchange.com/questions/264962/print-lines-of-a-file-between-two-matching-patterns)
- [Delete all lines from a file](https://stackoverflow.com/questions/8206280/delete-all-lines-beginning-with-a-from-a-file)
- [Using printf to print %s placeholder](https://unix.stackexchange.com/questions/519315/using-printf-to-print-variable-containing-percent-sign-results-in-bash-p)

---

<small>

Template generated by ChatGPT  
Documentation generated by [PADDOCS](https://padsrepo.github.io/pads/#paddocs)  
Compendium section: 19-blog  
Title: [Title]  
Author: [Name]  
Tags: [project, update, devlog]  
Status: [ **Draft** / Final / Reviewed ]  
Post ID: [File Name].md  
Template: 00-blog.md
License: "All Rights Reserved"  
Schema: articles  
Version: 0.0.1  
Branding: Wormhole / PADS  
</small>
