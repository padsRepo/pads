#!/bin/bash

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
