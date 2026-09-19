 #!/bin/bash

# Description: Make your PKGBUILD file for a specific pkg.
#
# Args:
#   $1: Name of your projects bin file.
#
# Returns:
#    0: Success
#    1: No such file or directory
#
# Examples:
#    pkgbuildFile binCmd
#      : Output the PKGBUILD file to the terminal.
#    pkgbuildFile binCmd > /path/to/pkgbuild/PKGBUILD
#      : Output the PKGBUILD file to a file.
pkgbuildFile(){
  . "${baseDir}/${0##*/}/utils.sh"
  extract $1
  cat << EOF
# Maintainer: ${author} ${email}
pkgname=${pkgname}
pkgver=${pkgver:-0.1.0}
pkgrel=1
epoch=
pkgdesc="${sub}"
arch=("x86_64")
url="${docs}/${pkgname}"
license=("MIT")
groups=()
depends=()
makedepends=()
checkdepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=".install"
changelog="CHANGELOG.md"
source=("\$pkgname-\$pkgver.tar.gz")
noextract=()
sha256sums=("SKIP")
validpgpkeys=()

prepare() {
  printf " :: Preparing...\n"
}

build() {
  printf " :: Building... \n"
}

#check() {
#  cd "\$pkgname-\$pkgver"
#  make -k check
#}

package() {
  mkdir -p \${pkgdir}/opt/pads/bin
  mv \${srcdir}/source/bin/\${pkgname} \${pkgdir}/opt/pads/bin
  cp -a "\${srcdir}/source/\${pkgname}" "\${pkgdir}/opt/pads/"
  #make DESTDIR="\$pkgdir/" install
}
EOF
}

# Description: Make your .install file for a specific pkg.
#
# Args:
#   None
#
# Returns:
#    0: Success
#    1: No such file or directory
#
# Examples:
#    installFile
#      : Output the .install file to the terminal.
#    installFile > /path/to/pkgbuild/.install
#      : Output the .install file to a file.
installFile(){
  cat << EOF
# This is a default template for a post-install scriptlet.
# Uncomment only required functions and remove any functions
# you don't need (and this header).

## arg 1:  the new package version
#pre_install() {
#  echo "pre_install"
#}

## arg 1:  the new package version
#post_install() {
#	echo "post_install..."
#}

## arg 1:  the new package version
## arg 2:  the old package version
#pre_upgrade() {
	# do something here
#}

## arg 1:  the new package version
## arg 2:  the old package version
#post_upgrade() {
	# do something here
#}

## arg 1:  the old package version
#pre_remove() {
	# do something here
#}

## arg 1:  the old package version
#post_remove() {
	# do something here
#}
EOF
}

# Description: Make your bin file including [paddocs] tags.
#
# Args:
#   $1: Name of bin command
#   ${@:2}: Subtitle for command (optional)
#
# Returns:
#    0: Success
#    1: No such file or directory
#
# Examples:
#    cmdFile binCmd "My awesome subtitle"
#      : Output the bin file to the terminal. Includes a subtitle.
#    cmdFile binCmd > /path/to/bin/binCmd
#      : Output the bin file to your bin directory. It will be executable.
cmdFile(){
  pkgname="${1}"
  sub="${@:2}"
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname>\n" && return 2
  cat << BODY
#!/bin/bash

## title ${pkgname:-"Give this guy a name."}
## subtitle ${sub:-"Get cho' self a new subtitle son."}
## brief
## desc
## author
## email
## created
## repoURL
## docsURL
## blogURL
## version ${pkgver:-0.1.0}
## copyright
## end copyright
## lic
## synopsis
## syntax
## exit
## end exit
## env
## end env
## file
## end file
## history
##  - $(date)
##    - Created initial project
## end history
## note
## end note
## example
## end example
## seealso
## sourcecode
## readme
## end readme

title="${pkgname:-"Give this guy a name."}"
subtitle="${sub:-"Get cho' self a new subtitle son."}"
version="${pkgver:-0.1.0}"
OPTSTRING="h,v"
synopsis="<cmd> -[<module>] -[<argument>] -[<option>] [name...]"
syntax="\${0##*/} -[\${OPTSTRING}] -[arg]"
baseDir="\$(dirname "\$(readlink -f "\${0%/*}")")"

. "\${baseDir}/padsutils/config/pads.rc"

description(){
  cat << EOF
 * \${title}
 * \${subtitle}

EOF
}

usage(){
  cat << EOF
  Synopsis: \$synopsis
  Syntax: \$syntax
  Usage:
    -v      Show Version
    -h      Show Usage
  Ex:
  See also:
EOF
}

manual(){
  description
  usage
}

while getopts \${OPTSTRING} name; do
  case \${name} in
    v) echo "\${version}"; exit;;
    h) usage; exit;;
    ?) echo " * \${0##*/} -h for help"; exit 2;;
    *) echo "K18 Error"; exit 2;;
  esac
done
[[ \$# -eq 0 ]] && manual && exit
\$cmd -\$arg
BODY
  #[[ -f "${baseDir}/bin/${pkgname}" ]] && chmod +x "${baseDir}/bin/${pkgname}"
}

# Description: Make your bin file including [paddocs] tags.
#
# Args:
#   $1: Name of bin command
#   ${@:2}: Subtitle for command (optional)
#
# Returns:
#    0: Success
#    1: No such file or directory
#
# Examples:
#    cmdFile binCmd "My awesome subtitle"
#      : Output the bin file to the terminal. Includes a subtitle.
#    cmdFile binCmd > /path/to/bin/binCmd
#      : Output the bin file to your bin directory. It will be executable.
pyprojectFile(){
  [[ $# -eq 0 ]] && printf "Syntax: ${FUNCNAME} <pkgname> [subtitle]\n" && return 2
  cat << EOF
[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "${pkgname}"
version = "0.0.0"
description = "Test CLI"
readme = "README.md"
requires-python = ">=3.8"
license = {text = "MIT"}
authors = [
  { name = "Joe Corso", email = "pads.email.address@gmail.com" }
]
maintainers = [
  { name = "Joe Corso", email = "pads.email.address@gmail.com" }
]

keywords = ["CLI", "Test"]
classifiers = [
  "Development Status :: 3 - Alpha",
  "License :: OSI Approved :: MIT License",
  "Programming Language :: Python :: 3",
  "Programming Language :: Python :: 3.11",
  "Programming Language :: Python :: 3.12",
  "Framework :: Flask"
]
dependencies = [
  "click>=8.3.1",
]

[project.urls]
Homepage = "https://your.project.homepage"  # Optional
Repository = "https://github.com/yourusername/interlink"  # Optional

[tool.setuptools]
package-dir = {"" = "src"}

[tool.setuptools.packages.find]
where = ["src"]

[tool.setuptools.package-data]
"${pkgname}" = ["cli/*"]

[project.scripts]
${pkgname} = "${pkgname}.cli:cli"
EOF
}

# Description: Make your bin file including [paddocs] tags.
#
# Args:
#   $1: Name of bin command
#   ${@:2}: Subtitle for command (optional)
#
# Returns:
#    0: Success
#    1: No such file or directory
#
# Examples:
#    cmdFile binCmd "My awesome subtitle"
#      : Output the bin file to the terminal. Includes a subtitle.
#    cmdFile binCmd > /path/to/bin/binCmd
#      : Output the bin file to your bin directory. It will be executable.
pycliFile(){
  cat << EOF
# This file is used to run the pkg from the CLI..
# Copyright Joe Corso pads.email.address@gmail.com

'''
This is a description of the package.
'''

import click
import os

__version__ = "0.0.1"

@click.group()
@click.version_option(__version__)
def cli():
  ''' CLI Mode '''
  print("CLI MODE")

@cli.command('replaceme')
@click.option('-t', '--table', required=True, help='The table to generate a report for', default='rawMaterials')
def report():
  '''Generate a report for table'''
  print("Test Command.")
  
if __name__ == '__main__':
    cli() 
EOF
}

dryrun(){
  pkgbuildFile $1
  echo $version $subtitle
}

usage(){
  cat << EOF
  Syntax: ${0##*/} -${mod} <arg> <opt>
  Usage:
    -p --pkgbuild <name>       Create PKGBUILD File. Must specify directory.
    -i --install               Create .install File. Must specify directory.
    -c --command <name>        Create bin command File. Must specify directory.
    -l --pyprojectFile <name>  Create pyproject.toml file
    -x --pycli <name>          Create CLI file for a py project
    -t --test <name>           Test things
    -h --help                  Show Usage
  Ex: ${0##*/} -${mod}p padsutils > /path/to/dir/PKGBUILD
EOF
}
