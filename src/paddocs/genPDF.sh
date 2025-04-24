#!/bin/bash

pandoc --toc --pdf-engine=xelatex --metadata pagetitle="$cmd" "$save_dir/${cmd}.md" -o "$save_dir/${cmd}.pdf"
[[ $? -eq 0 ]] && printf " :: Generated $cmd.pdf\n"
