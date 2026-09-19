#!/bin/bash

pads -C --directory ~/new devEnv.txt
pads -C --directory ~/new/shcmd shEnv.txt
pads -C --file ~/new/shcmd files.txt
pads -T --command shcmd > ~/new/shcmd/source/bin/shcmd
cp ~/dev/pads/source/bin/pads ~/new/shcmd/source/bin/shcmd
chmod +x ~/new/shcmd/source/bin/shcmd
pads -B --pkgbuild shcmd
pads -U --updateRepo shcmd
paddocs -B --buildDocumentation shcmd
paddocs -G --genChapter 10 shcmd html shcmd/docs/page
paddocs -G --genWiki shcmd