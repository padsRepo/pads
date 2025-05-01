#!/bin/bash

file=~/pads/bin/${cmd}
dir="/mnt/docs/paddocs"
save_dir="$dir/pads/$cmd"

# headers to use:
title=$(cat "$file" | grep "## title" | sed s/"## title "//g)
subtitle=$(cat "$file" | grep "## subtitle" | sed s/"## subtitle "//g)
brief=$(cat "$file" | grep "## brief" | sed s/"## brief "//g)
desc=$(cat "$file" | sed -n "/## desc/,/## end desc/{//!p}" | sed s/"## //g")
author=$(cat "$file" | grep "## author" | sed s/"## author "//g)
email=$(cat "$file" | grep "## email" | sed s/"## email "//g)
created=$(cat "$file" | grep "## created" | sed s/"## created "//g)
repoURL=$(cat "$file" | grep "## repoURL" | sed s/"## repoURL "//g)
docsURL=$(cat "$file" | grep "## docsURL" | sed s/"## docsURL "//g)
blogURL=$(cat "$file" | grep "## blogURL" | sed s/"## blogURL "//g)
version=$($cmd -v)
copyright=$(cat "$file" | sed -n "/## copyright/,/## end copyright/{//!p}" | sed s/"## //g")
lic=$(cat "$file" | grep "## license" | sed s/"## license "//g)
synopsis=$(${cmd} -h | grep "Synopsis: " | sed s/"Synopsis: "//g)
syntax=$(${cmd} -h | grep "Syntax: " | sed s/"Syntax: "//g)
usageOpts=$(${cmd} -h | sed -n "/Usage:/,/Ex:/{//!p}")
status=$(cat "$file" | sed -n "/## exit/,/## end exit/{//!p}" | sed s/"## //g")
envvars=$(cat "$file" | sed -n "/## env/,/## end env/{//!p}" | sed s/"## //g")
dirs=$(cat "$file" | sed -n "/## file/,/## end file/{//!p}" | sed s/"## //g")
history=$(cat "$file" | sed -n "/## history/,/## end history/{//!p}" | sed s/"## //g")
note=$(cat "$file" | sed -n "/## note/,/## end note/{//!p}" | sed s/"## //g")
example=$(cat "$file" | sed -n "/## example/,/## end example/{//!p}" | sed s/"## //g")
sourcecode=$(sed -e '/^#/d' -e '/^$/d' "$file")
seealso=$(cat "$file" | grep "## seealso" | sed s/"## seealso "//g)
quickstart=$(cat "$file" | sed -n "/## quickstart/,/## end quickstart/{//!p}" | sed s/"## //g")

[[ -n $status ]] && stat="Exit Status\n|Code|Status|\n|-----|-----|\n$status\n"
[[ -n $repoURL ]] && repo="Repository: $repoURL\n"
[[ -n $blogURL ]] && blog="Blog: $blogURL\n"
[[ -n $docsURL ]] && docs="Blog: $docsURL\n"
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
printf -v printsource "Source Code\n  ~~~bash\n%s\n~~~\n" "${sourcecode}"
