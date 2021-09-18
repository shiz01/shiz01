# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A header only library for creating and validating json web tokens in C++."
HOMEPAGE="https://github.com/Thalhammer/jwt-cpp"
SRC_URI="https://github.com/Thalhammer/${PN}/archive/v${PV}.tar.gz"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="MIT"
SLOT="0"
IUSE="coverage examples system-picojson test"
RESTRICT="!test? ( test )"

DOCS=( LICENSE README.md )

src_configure() {
	local mycmakeargs=(
		-DJWT_BUILD_TESTS=$(usex test)
		-DJWT_BUILD_EXAMPLES=$(usex examples)
		-DJWT_ENABLE_COVERAGE=$(usex coverage)
		-DJWT_EXTERNAL_PICOJSON=$(usex system-picojson)
	)
	cmake_src_configure
}

src_install() {
	DESTDIR=${D} cmake_src_install

	mkdir -p "${ED}/usr/$(get_libdir)/cmake"
	mv "${ED}/usr/cmake" "${ED}/usr/$(get_libdir)"
	rmdir "${ED}/usr/cmake" &> /dev/null

	for i in ${DOCS[@]}; do
		dodoc $i;
	done;


}

