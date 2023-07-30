# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Finite state machine library based on the boost hana meta programming library."
HOMEPAGE="https://github.com/erikzenker/hsm"
SRC_URI="https://github.com/erikzenker/hsm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~arm ~x86"

DEPEND=">=dev-libs/boost-1.72"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND} >=dev-util/cmake-3.14"

