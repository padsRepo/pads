#!/bin/bash

[[ ! ${prefix} =~ "html"|"pdf"|"md"|"markdown" ]] && echo "Pick Prefix" && exit

genBook(){
  # ./manuscript/19-blog/{*.md,*/*.md} IS NOT WORKING
  output="compendium.${prefix}"
  save_dir="${base_dir}/src/paddocs/output/book/${output}"
  pandoc -s --toc --citeproc --number-sections --toc-depth=2 --from markdown -t ${prefix} --include-before-body="./includes/header.${prefix}" --include-after-body="./includes/footer.${prefix}" --pdf-engine=lualatex --metadata-file="./manuscript/metadata.yaml" --template="./config/template.${prefix}" ./manuscript/00-front/*.md ./manuscript/10-docs/{*-cover.md,*/*.*md} ./manuscript/12-business/{*-cover.md,*/*.md} ./manuscript/13-property/{*-cover.md,*/*.md} ./manuscript/18-tutorials/{*-cover.md,*/*.md} ./manuscript/19-blog/{*-cover.md,*/*.md} ./manuscript/20-notes/*.md ./manuscript/99-back/*.md -o ${save_dir}
}

genSection(){
  # should generate man page but also the 11-manual section
  [[ ! ${sectionName} =~ "docs"|"manual"|"business"|"tenants"|"tutorials"|"blog" ]] && printf "Pick section name\n" && exit
  output="${sectionName}.${prefix}"
  save_dir="${base_dir}/paddocs/output/sections/${output}"
  pandoc -s --toc --toc-depth=2 --from markdown -t ${prefix} --include-before-body="./includes/header.${prefix}" --include-after-body="./includes/footer.${prefix}" --pdf-engine=lualatex --css="../../config/responsive.css" --csl="./config/apa.csl" --template="./config/template.${prefix}" ./manuscript/*-${sectionName}/metadata.yaml ./manuscript/*-${sectionName}/{00-cover.md,*/*.md} -o ${save_dir}
}

genChapter(){
  path=$(find "${base_dir}/src/paddocs" -type d -iname "${sectionName}" | head -1)
  echo ${path%/*}
  output="${sectionName}.${prefix}"
  save_dir="${base_dir}/src/paddocs/output/chapters/${output}"
  if [[ ${prefix} == "html"  || ${prefix} == "pdf" || ${prefix} == "md" ]]; then
    pandoc -s --toc --citeproc --number-sections --toc-depth=2 --from markdown -t ${prefix} --pdf-engine=lualatex --template="./config/template.${prefix}" ${path%/*}/metadata.yaml $path/*.md -o ${save_dir}
  fi
}

genMan(){
  output="${cmd}.1"
  man_dir="${PADS_DIR}/paddocs/manuscript/11-manual/"
  save_dir="/usr/share/man/man1"
  cp "${man_dir}/${cmd}.1.md" "${man_dir}/${output}"
  pandoc "${man_dir}/${output}" -s -f markdown -t man -o "${man_dir}/${output}"
  gzip -fv "${man_dir}/${output}" &> /dev/null
  sudo mv "${man_dir}/${output}.gz" "${save_dir}"
  [[ $? -eq 0 ]] && msg "\nGenerate: ${prefix} \nCMD: ${output} \nFile: file://${man_dir}/${output}\n" && exit 0 || exit 1
}

if [[ ${type} == "book" ]]; then
  genBook
elif [[ ${type} == "section" ]]; then
  genSection
elif [[ ${type} == "chapter" ]]; then
  genChapter
elif [[ ${type} == "man" ]]; then
  genMan
fi


