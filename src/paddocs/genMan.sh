#!/bin/bash

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
