# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

LUA_COMPAT=( lua5-{1..4} luajit )

inherit cmake-utils lua

DESCRIPTION="Lua API wrapper with advanced features and top notch performance."
HOMEPAGE="https://github.com/ThePhD/sol2"
SRC_URI="https://github.com/ThePhD/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="${LUA_DEPS}"
REQUIRED_USE="${LUA_REQUIRED_USE}"


