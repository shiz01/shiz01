# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A header only library for creating and validating json web tokens in C++."
HOMEPAGE="https://github.com/Thalhammer/jwt-cpp"
SRC_URI="https://github.com/Thalhammer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

DOCS=( LICENSE README.md )

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS=$(usex test)
	)
	cmake_src_configure
}

src_install() {
	DESTDIR=${D} cmake_src_install
	mkdir -p "${ED}/usr/$(get_libdir)/cmake/"
	mv "${ED}/usr/${PN}" "${ED}/usr/$(get_libdir)/cmake/"

	for i in ${DOCS[@]}; do
		dodoc $i;
	done;


}

