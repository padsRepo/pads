#!/bin/bash

printf \
"
# $licl

# $copy
" > "$save_dir/LICENSE.md"
echo ":: Generated: LICENSE.md"
[[ $? -eq 0 ]] && printf " :: Generated: LICENSE.md\n"
