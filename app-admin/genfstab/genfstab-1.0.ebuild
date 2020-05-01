# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="The fstab generator"
HOMEPAGE="https://github.com/glacion/genfstab"
SRC_URI="https://github.com/glacion/${PN}/archive/${PV}.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86" # ~arm ~arm64
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin ${PN}
}
