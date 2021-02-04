# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="cr.h: A Simple C Hot Reload Header-only Library."
HOMEPAGE="https://github.com/fungos/cr"
EGIT_REPO_URI="https://github.com/fungos/cr"
EGIT_COMMIT="93283df25c37db331aca1f68657ae90935ebea7d"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( LICENSE README.md )

src_install() {
	mkdir "${S}/${PN}";
	cp "${S}/${PN}.h" "${S}/${PN}";
	doheader -r "${S}/${PN}";
	for i in ${DOCS[@]}; do
		dodoc $i;
	done;
}

