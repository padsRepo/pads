#!/bin/bash

# find section number:
# $ for i in $(cat output/compendium.html | grep "toc-section-number" | sed 's/.*toc-section-number\">//; s/<\/span.*//'); do printf "Section: $i\n"; done

parseBash(){
  dir="10-docs"
  [[ ${build} == "man" ]] && dir="11-manual"
  file=$(find "${base_dir}/bin" -type f -iname "$cmd")
  cmd=${file}
  #projDir=$(dirname $(find /*/dev/ -type f -iname ".padsrc"))
  savePath="$(find "${base_dir}" -type d -iname "${dir}")/pads/${file##*/}.md"

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
  mod=$(cat "$file" | sed -n "/## module/,/## end module/{//!p}" | sed s/"##//g")
  apiCall=$(cat "$file" | sed -n "/## api/,/## end api/{//!p}" | sed s/"##//g")
  history=$(cat "$file" | sed -n "/## history/,/## end history/{//!p}" | sed s/"## //g")
  note=$(cat "$file" | sed -n "/## note/,/## end note/{//!p}" | sed s/"^## //g")
  example=$(cat "$file" | sed -n "/## example/,/## end example/{//!p}" | sed s/"## //g")
  sourcecode=$(sed -e '/^#/d' -e '/^$/d' "$file")
  seealso=$(cat "$file" | grep "## seealso" | sed s/"## seealso "//g)
  quickstart=$(cat "$file" | sed -n "/## readme/,/## end readme/{//!p}" | sed s/"^## //"g)
  advanced=$(cat "$file" | sed -n "/## advanced/,/## end advanced/{//!p}" | sed s/"##//g")
  trouble=$(cat "$file" | sed -n "/## troubleshoot/,/## end troubleshoot/{//!p}" | sed s/"##//g")
  contributing=$(cat "$file" | sed -n "/## contributing/,/## end contributing/{//!p}" | sed s/"##//g")

  [[ -n $status ]] && stat="|Code|Status|\n|-|-|\n$status\n"
  [[ -n $repoURL ]] && repo="Repository: $repoURL\n"
  [[ -n $blogURL ]] && blog="Blog: $blogURL\n"
  [[ -n $docsURL ]] && docs="Docs: $docsURL\n"
  [[ -n $author ]] && auth="$author\n"
  [[ -n $version ]] && ver="$version\n"
  [[ -n $copyright ]] && copy="$copyright\n"
  [[ -n $lic ]] && licl="$lic\n"
  [[ -n $envvars ]] && env="|Key|Value|\n|-|-|\n$envvars\n"
  [[ -n $dirs ]] && fdir="|Files/Directories|Path|Description|\n|-|-|-|\n$dirs\n"
  [[ -n $mod ]] && module="|Script|Description|\n|-|-|\n${mod}"
  [[ -n $apiCall ]] && api="### API Reference \n|Function/Class|Module|Parameters|Returns|Description|\n|-|-|-|-|-|\n${apiCall}"
  [[ -n $history ]] && hist="$history\n"
  [[ -n $note ]] && notes="$note\n"
  [[ -n $example ]] && ex="$example\n"
  [[ -n $seealso ]] && see="$seealso\n"
  [[ -n $quickstart ]] && readme="$quickstart\n"
  [[ -n $synopsis || -n $syntax || -n $usageOpts ]] && usage="~~~$lang\n  $synopsis\n  $syntax\n$usageOpts\n\~~~\n\n"
  [[ -n $trouble ]] && troubleshoot="|Issue|Solution / Workaround|\n|-|-|\n$trouble"
  printf -v printsource "~~~bash\n%s\n~~~\n" "${sourcecode}"
}

parsePython(){
  # https://gabrielelanaro.github.io/blog/2014/12/12/extract-docstrings.html

  dir=$(find $HOME/code/${cmd}/src -type d -iname "$cmd")
  projDir=$(printf "$dir" | head -1)
  saveFile="${cmd}.md"
  saveDir=$(find $HOME/code/pads/build/src/paddocs/manuscript -type d -iname "$cmd" | grep "10-docs")
  python -c "
import ast
import os

number = 10
projDir = '${projDir}'
projFile = '__init__.py'
saveFile = '${saveFile}'
saveDir = '${saveDir}'
savePath = f'{saveDir}/{number}-{saveFile}'

if not os.path.exists(f'{saveDir}'):
    print(f'[ WARNING ] :: Not a path: {saveDir}\nMaking Dir')
    os.mkdir(saveDir)

if os.path.exists(f'{savePath}'):
  os.remove(f'{savePath}')
  print((f'[ Deleted ] :: {savePath}'))

with open(f'{projDir}/{projFile}') as f:
  tree = ast.parse(f.read())

for node in ast.walk(tree):
  if isinstance(node, ast.Assign):
    for target in node.targets:
      if isinstance(target, ast.Name) and target.id.startswith('__') and target.id.endswith('__'):
        try:
          value = ast.literal_eval(node.value)
        except:
          value = ''
        finally:
          open(f'{savePath}', 'a').write(f'*{target.id}*  \n\n{value}  \n\n')

'''
dunders = [(target.id, ast.literal_eval(node.value)) 
for node in ast.walk(tree) 
if isinstance(node, ast.Assign) 
for target in node.targets 
if isinstance(target, ast.Name) and target.id.startswith('__') and target.id.endswith('__')
]

version = f'### {dunders[0][0]}\n{dunders[0][1]}\n'
author = f'### {dunders[1][0]}\n{dunders[1][1]}\n'
date = f'### {dunders[2][0]}\n{dunders[2][1]}\n'
updated = f'### {dunders[3][0]}\n{dunders[3][1]}\n'
copyright = f'### {dunders[4][0]}\n{dunders[4][1]}\n'
license = f'### {dunders[5][0]}\n{dunders[5][1]}\n'
email = f'### {dunders[6][0]}\n{dunders[6][1]}\n'
status = f'### {dunders[7][0]}\n{dunders[7][1]}\n'
description = f'### {dunders[8][0]}\n{dunders[8][1]}\n'

data = [(path, dirname, filename) for path, dirname, filename in os.walk(projDir)]
path = [path for path, dirname, filename in os.walk(projDir)]
dirname = [dirname for path, dirname, filename in os.walk(projDir) for dirname in dirname if dirname != '__pycache__' and dirname != 'Interlink.egg-info']
filename = [filename for path, dirname, filename in os.walk(projDir)]

open(f'{savePath}', 'a').write('\n' + '\n\n' + version + '\n' + author + '\n' + date + '\n' + updated + '\n' + copyright + '\n' + license + '\n' + email + '\n' + status + '\n')
'''

for path, dirname, filename in os.walk(projDir):
  # print(f'Path: {path} \n Dir: {dirname} \n File: {sorted(filename)}')
  for x in sorted(filename):
    # print(f'x: {x}')
    # print(sorted(x))
    if x.endswith('.py'):
      filename = f'{path}/{x}'
      # print(filename)
      
      with open(filename) as fd:
        # print(fd)
        module = ast.parse(fd.read())
        # print(module.body[0])
      
      class_definitions = [node for node in module.body if isinstance(node, ast.ClassDef)]
      function_definitions = [node for node in module.body if isinstance(node, ast.FunctionDef)]
      if ast.get_docstring(module) is not None:
        open(f'{savePath}', 'a').write('\\\pagebreak' + '\n## ' + os.path.basename(path) + '\n\n' + ast.get_docstring(module) + '\n\n')
      for c in class_definitions:
        if ast.get_docstring(c) is not None:
          open(f'{savePath}', 'a').write('### ' + c.name + '\n' + ast.get_docstring(c) + '\n\n')
        for cFun in c.body:
          if isinstance(cFun, ast.FunctionDef):
            open(f'{savePath}', 'a').write('#### ' + cFun.name + '\n' + str(ast.get_docstring(cFun)) + '\n\n')
      for f in function_definitions:
        if ast.get_docstring(f) is not None:
          open(f'{savePath}', 'a').write('### ' + f.name + '\n' + ast.get_docstring(f) + '\n\n')
  number += 1
  "
  cd ${saveDir}
  # replace googlestyle docs with markdown links to each mod, class, or function.
  sed -E -e '/Modules:/,/^$/ {' -e '/Modules:/b' -e 's/([a-zA-Z0-9_]+):/[\1](#\L\1) | /g' -e '}' \
    -e '/Classes:/,/^$/ {' -e '/Classes:/b' -e 's/([a-zA-Z0-9_]+):/[\1](#\L\1) | /g' -e '}' \
    -e '/Functions:/,/^$/ {' -e '/Functions:/b' -e 's/([a-zA-Z0-9_]+):/| [\1](#\L\1) | /g' -e '}' \
    -e '/Returns:/,/^$/ {' -e '/Returns:/b' -e 's/([a-zA-Z0-9_()]+):/\1 | /g' -e '}' \
    -e '/Args:/,/^$/ {' -e '/Args:/b' -e 's/([a-zA-Z0-9_()]+):/\1 | /g' -e '}' \
    -e '/Attributes:/,/^$/ {' -e '/Attributes:/b' -e 's/([a-zA-Z0-9_()]+):/\1 | /g' -e '}' \
    -e '/Raises:/,/^$/ {' -e '/Raises:/b' -e 's/([a-zA-Z0-9_()]+):/\1 | /g' -e '}' \
    1*.md > file.txt
  # Style it for a table
  sed -i s/"Modules:"/"| Modules | Description |\n|-|-|"/g file.txt
  sed -i s/"Classes:"/"| Classes | Description |\n|-|-|"/g file.txt
  sed -i s/"Functions:"/"| Functions | Description |\n|-|-|"/g file.txt
  sed -i s/"Args:"/"| Args | Description |\n|-|-|"/g file.txt
  sed -i s/"Returns:"/"| Returns | Description |\n|-|-|"/g file.txt
  sed -i s/"Attributes:"/"| Attributes | Description |\n|-|-|"/g file.txt
  sed -i s/"Raises:"/"| Raises | Description |\n|-|-|"/g file.txt
  rm 1*.md
  mv file.txt 10-${cmd}.md
}
