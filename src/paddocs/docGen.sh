#!/bin/bash

. "${base_dir}/src/paddocs/vars.sh"

[[ ! -d $save_dir ]] && mkdir $save_dir

genREADME(){

  printf "# $title
$desc\n
 - $repo
 - $blog
 - $docs
# $quickie
  " > "$save_dir/README.md"
  [[ $? -eq 0 ]] && printf " :: Generated: README.md\n"
}

genLicense(){
  printf \
  "
# $licl

# $copy
  " > "$save_dir/LICENSE.md"
  echo ":: Generated: LICENSE.md"
  [[ $? -eq 0 ]] && printf " :: Generated: LICENSE.md\n"
}

genWiki(){
  printf \
"
---
header-includes:
 - %s
 - %s
---

# $title
$brief
$created\n
## Introduction\n
### Description
$desc\n
### $auth
### $ver
### $copy
### $licl
## $usage
## $stat
## $env
## $fdir
## $hist
## $notes
## $ex
## %s
## $see
" "\usepackage{fvextra}" "\DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\\\{\}}" "${printsource}" > "$dir/pads/wiki/${cmd}.md"
  [[ $? -eq 0 ]] && printf " :: Generated: wiki/$cmd.md\n"
}

genWikiHome(){
  printf "
$desc\n
 - $repo
 - $blog
 
## $quickie
## $stat
## $env
## $fdir
## $hist
## $notes
## $licl
## $copy
## $auth
  " > "$dir/pads/wiki/Home.md"
  [[ $? -eq 0 ]] && printf " :: Generated: Home.md\n"
}

genSrc(){  
  printf \
"
---
header-includes:
 - %s
 - %s
---

# $title
$brief
$created\n
## Introduction\n
### Description
$desc\n
 - $repo
 - $blog
## $auth
## $ver
## $copy
## $licl
# $usage
# $stat
# $env
# $fdir
# $hist
# $notes
# $ex
# %s
# $see
" "\usepackage{fvextra}" "\DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\\\{\}}" "${printsource}" > "$save_dir/${cmd}.md"
  [[ $? -eq 0 ]] && printf " :: Generated: $cmd.md\n"
}

genInfo(){
  printf \
"
---
title: $title $subtitle
section: 1
version: $version
header: Comprehensive Documentation
footer: $title $version
date: $created
toc: true
navOrder: forward, updates, command line, tutorials, reference
---

$brief

$copyright

"
}

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

# OPTIONS
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
  sudo mv $save_dir/$cmd.1.gz /usr/local/man/man1
}

genHTML(){
  pandoc -s --toc --number-sections --highlight-style=pygments -c "$dir/templates/jez.css" --template "$dir/templates/jez.html" --metadata pagetitle="${cmd}" $save_dir/${cmd}.md -o "$save_dir/${cmd}.html"
  [[ $? -eq 0 ]] && printf " :: Generated: $cmd.html\n"
}

genMain(){
  pandoc -s --toc --number-sections --highlight-style=pygments -c "$dir/templates/jez.css" --template "$dir/templates/jez.html" --metadata pagetitle="PADS" $dir/pads/wiki/*.md -o "$dir/pads/print/padsguide.html"
  pandoc --toc -s --metadata pagetitle="PADS Guide" $dir/pads/wiki/*.md -o "$dir/pads/print/padsguide.pdf"
  [[ $? -eq 0 ]] && printf " :: Generated: index.html\n"
}

genPDF(){
  pandoc --toc --pdf-engine=xelatex --metadata pagetitle="$cmd" "$save_dir/${cmd}.md" -o "$save_dir/${cmd}.pdf"
  cp "$save_dir/${cmd}.pdf" "$dir/pads/print"
  [[ $? -eq 0 ]] && printf " :: Generated $cmd.pdf\n"
}
