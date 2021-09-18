# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="fast-cpp-csv-parser."
HOMEPAGE="https://github.com/ben-strasser/fast-cpp-csv-parser"
EGIT_REPO_URI="https://github.com/ben-strasser/fast-cpp-csv-parser"
EGIT_COMMIT="75600d0b77448e6c410893830df0aec1dbacf8e3"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_install() {
	mkdir -p ${S}/${PN}
	mv ${S}/csv.h ${S}/${PN}
	doheader -r ${S}/${PN}
}

