# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++17 string with fixed size"
HOMEPAGE="https://github.com/unterumarmung/fixed_string"
SRC_URI="https://github.com/unterumarmung/fixed_string/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"


