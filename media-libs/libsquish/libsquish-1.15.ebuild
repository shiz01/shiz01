# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-utils

DESCRIPTION="Open source DXT compression library."
HOMEPAGE="https://sourceforge.net/projects/libsquish/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${P}.tgz/download -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+cpu_flags_x86_sse2 extra +openmp +shared"

S="${WORKDIR}"

pkg_pretend() {
	if [[ ${MERGE_TYPE} != binary ]] && use openmp; then
		tc-has-openmp || die "Please switch to an openmp compatible compiler"
	fi
}

src_prepare() {
	eapply_user
	sed -i "s/DESTINATION\ lib/DESTINATION\ $(get_libdir)/" ${S}/CMakeLists.txt
	append-flags -fPIC
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SQUISH_EXTRA=$(usex extra)
		-DBUILD_SHARED_LIBS=$(usex shared)
		-DBUILD_SQUISH_WITH_SSE2=$(usex cpu_flags_x86_sse2)
		-DBUILD_SQUISH_WITH_OPENMP=$(usex openmp)
	)
	cmake-utils_src_configure
}

