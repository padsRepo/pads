#!/bin/bash
# This script builds the PKGBUILD, and compresses the pkg for you.

base_dir="$(dirname "$(readlink -f "${0##/*}")")"

pkgname=${1}
pkgver=$(${base_dir}/build/bin/${pkgname} -v)
poolDir="${base_dir}/pool/${pkgname}"

[[ ! -d ${poolDir} ]] && mkdir -p ${poolDir}
[[ ! -d /srv/pkg/core/${pkgname} ]] && sudo mkdir -p /srv/pkg/core/${pkgname}

cd ${base_dir}
tar -cf $pkgname-$pkgver.tar.gz ./build/{bin/$pkgname,src/${pkgname}}

cat << EOF > PKGBUILD
# Maintainer: Joe Corso <joe.corso.email@gmail.com>
pkgname=$pkgname
pkgver=$pkgver
pkgrel=1
epoch=
pkgdesc="Personal Assistant and Deployment System"
arch=('x86_64')
url="https://padsrepo.github.io/pads/"
license=('MIT')
groups=("pads-meta")
depends=("pads-meta")
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
sha256sums=('SKIP')
validpgpkeys=()

prepare() {
	#cd "\$pkgname-\$pkgver"
	printf " :: Preparing...\n"
	#echo "mkdir \$pkgname"
	#echo "cd \$pkgname"
	#[[ -f "\${pkgname}-\${pkgver}.patch" ]] && printf " :: Preparing to patch..." || printf " :: No patch file found...\n"
}

build() {
    printf " :: Building... \n"
    #cd "\$pkgname"
    #mkdir -p build/src
	#echo \$PWD
	#cp bin/pads build/
	#cp src/pads/* build/src/
	#./configure --prefix=/usr
	#make
}

#check() {
#	cd "\$pkgname-\$pkgver"
#	make -k check
#}

package() {
    printf ":: Packaging...\n"
	mkdir -p \${pkgdir}/opt/pads/{bin,src/\${pkgname}}
	install -m755 \${srcdir}/build/bin/\${pkgname} \${pkgdir}/opt/pads/bin
	cp -a \${srcdir}/build/src/\${pkgname}/* \${pkgdir}/opt/pads/src/\${pkgname}
	#make DESTDIR="\$pkgdir/" install
}
EOF

# Build the pkg, and copy to repository directory
# Repo assumed to be `/srv/db/core/archRepo.db.tar.zst` and `/srv/pkg/core/$pkgname-$pkgver*.pkg.tar.zst`
# pkgs are built and saved in the `pool/` directory. each version will be a different .tar.gz file.
makepkg -s --clean
mv $pkgname-$pkgver* ${poolDir}
mv PKGBUILD ${poolDir}
cp {.install,.SRCINFO} ${poolDir}
sudo rm /srv/db/core/$pkgname*
sudo cp ${poolDir}/$pkgname-$pkgver*.gz /srv/pkg/core/${pkgname}
sudo cp ${poolDir}/{PKGBUILD,.install,.SRCINFO} /srv/pkg/core/${pkgname}
sudo mv ${poolDir}/*.pkg.* /srv/repo/db/core

# Add new pkg to your personal repository
# Remove any old pkgs (if any)
# You will still need to modify your pacman.conf file
cd /srv/db/core
repo-remove archRepo.db.tar.zst $pkgname
repo-add archRepo.db.tar.zst $pkgname-$pkgver*.pkg.tar.zst
