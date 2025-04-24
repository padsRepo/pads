#!/bin/bash

pandoc -s --toc --number-sections --highlight-style=pygments -c "$dir/templates/jez.css" --template "$dir/templates/jez.html" --metadata pagetitle="PADS" $dir/pads/wiki/*.md -o "$dir/pads/index.html"
[[ $? -eq 0 ]] && printf " :: Generated: index.html\n"
