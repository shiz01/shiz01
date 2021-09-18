# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Minimalistic MP3 decoder single header library."
HOMEPAGE="https://github.com/lieff/minimp3"
EGIT_REPO_URI="https://github.com/lieff/minimp3"
EGIT_COMMIT="ef9e212fa29bb72d23558da21bb5694fd2d01768"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_install() {
	mkdir -p ${S}/${PN}
	mv ${S}/${PN}.h ${S}/${PN}
	doheader -r ${S}/${PN}
}


