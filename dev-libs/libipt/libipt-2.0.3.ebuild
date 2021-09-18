# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake-utils

DESCRIPTION="Intel(R) Processor Trace decoder library."
HOMEPAGE="https://github.com/intel/libipt"
SRC_URI="https://github.com/intel/libipt/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+elf +man +pevent +ptdump ptxed +shared +sideband test +threads"

DEPEND="test? ( dev-lang/yasm )
		man? ( app-text/pandoc )
		ptxed? ( dev-libs/xed )
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"


src_configure() {
	local mycmakeargs=(
		-DFEATURE_THREADS=$(usex threads)
		-DPTDUMP=$(usex ptdump)
		-DPTXED=$(usex ptxed)
		-DPTTC=$(usex test)
		-DPTUNIT=$(usex test)
		-DMAN=$(usex man)
		-DSIDEBAND=$(usex sideband)
		-DBUILD_SHARED_LIBS=$(usex shared)
	)

	if use sideband && use pevent; then
		mycmakeargs+=( 
		-DPEVENT=$(usex pevent)
		)
	fi

	if use elf && use ptxed || use pevent && use elf; then
		mycmakeargs+=( 
		-DFEATURE_ELF=$(usex elf)
		)
	fi

	cmake-utils_src_configure
}

