#!/bin/bash

pandoc -s --toc --number-sections --highlight-style=pygments -c "$dir/templates/jez.css" --template "$dir/templates/jez.html" --metadata pagetitle="${cmd}" $save_dir/${cmd}.md -o "$save_dir/${cmd}.html"
[[ $? -eq 0 ]] && printf " :: Generated: $cmd.html\n"
