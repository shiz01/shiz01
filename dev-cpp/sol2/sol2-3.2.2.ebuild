# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Lua API wrapper with advanced features and top notch performance."
HOMEPAGE="https://github.com/ThePhD/sol2"
SRC_URI="https://github.com/ThePhD/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RDEPEND="dev-lang/lua"

