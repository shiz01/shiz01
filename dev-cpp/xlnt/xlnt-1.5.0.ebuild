# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="Cross-platform user-friendly xlsx library for C++11"
HOMEPAGE="https://github.com/tfussell/xlnt"
SRC_URI="https://github.com/tfussell/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples +shared test"
RESTRICT="!test? ( test )"

src_prepare(){
	# fix missing include <limits>
	local file="${S}/source/detail/number_format/number_formatter.cpp"
	{ echo '#include <limits>'; cat ${file}; } > ${file}.new && mv ${file}.new ${file};
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DTESTS=$(usex test)
		-DSAMPLES=$(usex examples)
		-DBENCHMARKS=OFF
		-DPYTHON=OFF
	)

	if ! use shared ; then 
		mycmakeargs+=( 
		-DSTATIC=ON
		)
		else
		mycmakeargs+=( 
		-DSTATIC=OFF
		)
	fi

	cmake_src_configure
}



