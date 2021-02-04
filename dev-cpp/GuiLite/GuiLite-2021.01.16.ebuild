# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="The smallest header-only GUI library(4 KLOC) for all platforms."
HOMEPAGE="https://github.com/idea4good/GuiLite"
EGIT_REPO_URI="https://github.com/idea4good/GuiLite"
EGIT_COMMIT="af67132479c65cb978688fa5395ed6816bfce6c7"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

src_install() {
	mkdir -p ${S}/${PN}
	mv ${S}/${PN}.h ${S}/${PN}
	doheader -r ${S}/${PN}
}

