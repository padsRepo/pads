---
header-includes:
 - \usepackage{fvextra}
 - \DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\}}
 - author: Joe Corso
 - title: Paddocs
 - email: pads.email.address@gmail.com
 - copyright: MIT 2025
 - created: 2025-04-08
 - subtitle: self-documenting code
---

# Motivation

I want to make a simple self documenting code concept. I like the direction of mkdocs, but I want the docs to generate for texinfo, groff, html, and a README for github. It seems overly complicating to me to use mkdocs, because it only wants to generate to html, to use like a wiki, as opposed to an info page, a man page, html, and a readme. pandoc on the otherhand will, but does not have a self-documenting code concept. These also depend on a lot of YAML files, and creating extra directories for the webpage, and self generating code, and you still need a source doc to generate from. I want it all to generate from the actual file with the code.

I think it would be simple enough to make my own self-documenting code using the same concept. Make headers in the file you're coding in, search for, and replace those headers in a markdown template that's generated from the paddocs code. Then you can use pandoc to parse the file to texi, groff, etc. You can still use mkdocs to deploy to github pages as well, just dont use the self generating concept. or make your own deployment to github pages, or the github wiki.


# Making the Program:

## Day 1: 2025-04-08

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
    
    `usageOpts=$($1 -h | sed -n '/Usage:/,/Ex:/{//!p}')`

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
       
Then combine it into a template. Something like this:

  --> template.md
   ~~~
    # title
    ## subtitle
    ### Description
    ### Author
    ### Version
    ### Copyright
   ~~~
  
  --> script.sh
   ~~~bash
    sed -e "s/title/$title/g" -e "/### Author/a\ \n$author\n" -e "/### Version/a\ \n$version\n" -e "/## Usage/a\ \n$usageOpts" template.md > $1.md
   ~~~
     
The issue I'm having with following this process is that the sed nested within the sed is finding the first dash (e.g -b) and trying to interpret it as a command, and of course failing. It may be easier to just use stdout to build the template as it goes. Something like this:

  --> script.sh
   ~~~bash
   printf "# Usage\n  $usageOpts" > $1.md
   ~~~
    
==================================================================================================================================

## Day 2: 2025-04-09

I was thinking I would just use stdout to print to a markdown file. It would be easier than trying to get this nested sed to work. Plus I won't have to make sure to carry around a template, because the code will generate the template. So let's go with that, and see where the next hiccup happens. 

I've spent the majority of the day trying to decide how much of the docs should generate from comments, and what should generate from code. For example, it makes sense to make comments at the top of the script to include creation date, author, copyright, version, and description of the script. But it also makes sense to just type `<cmd> -h` for a help, or `<cmd> -v` for the version. There would be excessive overhead to have to:

  ~~~bash
  version=$(cat "$file" | grep "## version" | sed s/"## version "//g)
  ~~~

As opposed to:

  ~~~bash
  version=$($cmd -v)
  ~~~
  
Some things would make sense to have as a header, (e.g copyright, license, creation date, long description, tutorial, examples, exit status)
Some things are already generated within the code, (e.g usage, version, syntax, synopsis, optstring).
For a section of the docs, that does not logically make sense to be the code, it would be easier to include tags like within html, so that you know to search for text within a pattern, and print that text as a string of characters. The easiest way to do that is with obvious, human-readable tags. For example:

  ~~~
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
  desc=$(cat "$file" | sed -n "/## desc/,/## end desc/{//!p}" | sed s/"## //g")
  ~~~

We can keep the `## ` on each line so that we can simultaneously run the command without errors, because the computer will consider those comments and not be parsed. Then just strip it all off to have a block of plain text. Trust me it's easier than using `sed` to search and replace complex patterns.

The next task was applying a nice looking template. This is where we can still use `pandoc` to generate the markdown file into nice looking html. I took some time to look around on github for an open source template to start with, and I found this:

  https://jez.io/pandoc-markdown-css-theme/

I would like to take time to come back to this, and create my own template (maybe incorporate it into templetons templates). But for now, I'm using the ones from above, and giving credit to the creator; until I can make my own. All I need for now is the format, the code blocks, and a nav. Pandoc can generate all of that execept the css and html. I'll use this command to generate the html:

  ~~~bash
  pandoc -s --toc --number-sections --highlight-style=pygments -c jez.css --template jez.html --metadata pagetitle="${cmd}" pads.md -o ${cmd}.html
  ~~~

That command alone will generate the table of contents(nav), numbered sections, the css template, the html template, a title, the input file(the self generated one), and an output file.
I think in the future I would make the html template with all the style and js on the same page so I don't have to package an entire library as a template that would have to piggyback off of each project. Just make one template with all the html, css, and js inline, then host on the github project which has the self generating code, then you can just bootstrap the template with https://github.com/my/pandoc/template.git. Easy. That part's done.

Next was the things like the exit status or env vars, and how to render that. So this is where the start and end tags win again. In your script all you have to do is place this somewhere in the file:

  ~~~
  ## exit 
  ## 0 | Success
  ## 1 | Failure
  ## 127 | K18
  ## 130 | Ctl+C
  ## end exit
  ~~~

The markdown format for a table is like this:

  ~~~
  | Syntax | Description |
  | ----------- | ----------- |
  | Header | Title |
  | Paragraph | Text | 
  ~~~

Notice that you need the pipe (`|`) in between so that it seperates it into the proper columns. So for this we would need sed again. We would need to find the text between the start and end tags, strip off the extra pound symbols `## ` and insert a pipe between the first whitespace. That last part gives me problems. If you do something like this:

  ~~~bash
  cat ~/pads/bin/pads | grep "## exit" | sed s/"## exit "//g | sed s/""/" | "/g
  ~~~

You get:
  
  ~~~bash
  sed: -e expression #1, char 0: no previous regular expression
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
  lang="${2}"
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

==================================================================================================================================

## Day 3: 2025-04-10

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

==================================================================================================================================

## Day 4: 2025-04-12

I want to think about adding an info page, but I might put that off for now. I don't think I have much more to add with an info page except that it's in the terminal, and it's more interactive then a man page. But my commands aren't so complex that they need a full info page, most of the information is good enough for a man page, or a simple `-h` flag. Having it online helps, because I can look up infomation on my phone if all I have is a terminal (no GUI, or web browser on the machine). But the info page I wanted to use as more of a comprehensive guid to all of it, including tutorials, like installing arch, setting up a website, etc. But if I'm stuck in a terminal, I use my phone because I wouldn't want to have to search the info page for step one, then close it, do the step, open it back up, search for step two, close it, do the step, open it back up, search for step three, etc. So really a PDF I can print out would be more handy, as opposed to more repetitive terminal information. But I do like me a good info page.

==================================================================================================================================

## Day 5: 2025-04-20

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

==================================================================================================================================

## Day 6: 2025-04-22

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
  " "${printsource}" > "$save_dir/${cmd}.md"
    [[ $? -eq 0 ]] && printf " :: Generated: $cmd.md\n"
  }
  ~~~
    
There it'll generate a code block for the source code.
I decided to strip off the text that generates the code, and just leave the actual code it takes up less space. I needed to strip off the `##` and the blank lines it left behind:

  `sed -e '/^#/d' -e '/^$/d' "$file"`
  
It's just my preference so it doesn't take up so much space. I don't care about the header for the self generating docs.
I should make a script that will generate examples and source code from the fuctions used in each command.


[1]: https://unix.stackexchange.com/questions/264962/print-lines-of-a-file-between-two-matching-patterns
[2]: https://stackoverflow.com/questions/8206280/delete-all-lines-beginning-with-a-from-a-file
[3]: https://unix.stackexchange.com/questions/519315/using-printf-to-print-variable-containing-percent-sign-results-in-bash-p
