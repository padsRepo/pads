#!/bin/bash

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
