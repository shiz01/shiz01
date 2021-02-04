# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A C++ compile-time math library using generalized constant expressions."
HOMEPAGE="https://www.kthohr.com/gcem.html"
SRC_URI="https://github.com/bombela/backward-cpp/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"


