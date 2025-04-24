#!/bin/bash

printf "# $title
$desc\n
 - $repo
 - $blog
 
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
