# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Symlink for genisoimage"
HOMEPAGE=""
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="app-cdr/cdrtools"

src_unpack(){
	mkdir -p ${S};
}

src_prepare() {
	eapply_user
	:;
}
src_compile() {
	:;
}
src_install() {
	dosym /usr/bin/mkisofs /usr/bin/genisoimage
}

