# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

DESCRIPTION="Consolas font."

LICENSE="Proprietary"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
FONT_SUFFIX="ttf"
RESTRICT="strip binchecks"

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}/consolas.ttf" "${WORKDIR}/"
	default
}
