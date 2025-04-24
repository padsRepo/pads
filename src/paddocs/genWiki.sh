#!/bin/bash

printf \
"# $title
$brief
$created\n
## Introduction\n
### Description
$desc\n
### $ver
## $usage
## $ex
## $see
" > "$dir/pads/wiki/${cmd}.md"
[[ $? -eq 0 ]] && printf " :: Generated: wiki/$cmd.md\n"
