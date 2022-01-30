# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Firmware for DSLogic"
HOMEPAGE="https://github.com/DreamSourceLab/DSView"
# SRC_URI="https://github.com/DreamSourceLab/DSView/tree/886b847c21c606df3138ce7ad8f8e8c363ee758b/DSView/res"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="sci-libs/libsigrok
		|| ( sci-electronics/sigrok-cli sci-electronics/pulseview )
"

src_unpack() {
	pushd ${FILESDIR}
	md5sum -c ${FILESDIR}/md5sum || die "Bad checksum!"
	mkdir "${S}" -vp || die "Error create dir ${S}"
	for i in $(ls ${FILESDIR}/*.fw); do
		cp ${i} ${S} -v || die "Error copy ${i} to ${S}";
	done
	popd
}
src_compile() { :; }

src_install() {
	tgt="/usr/share/sigrok-firmware"
	dodir ${tgt}
	insinto ${tgt}

	for i in $(ls ${S}/*.fw); do
		doins ${i};
	done
}


