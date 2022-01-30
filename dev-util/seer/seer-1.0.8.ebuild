# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Seer - a gui frontend to gdb"
HOMEPAGE="https://github.com/epasveer/seer"
SRC_URI="https://github.com/epasveer/seer/archive/refs/tags/v1.0.8.tar.gz -> ${P}.tar.gz"

LICENSE="undefined"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
"
RDEPEND="${DEPEND} sys-devel/gdb"
BDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-0001-fix-build.patch"
)
CMAKE_USE_DIR="${S}/src"

