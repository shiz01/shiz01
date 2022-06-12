# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit font

DESCRIPTION="Consolas font."

# https://fonts.google.com/download?family=Roboto%20Mono -> Roboto_Mono.zip

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
FONT_SUFFIX="ttf"
RESTRICT="strip binchecks"

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}/RobotoMono-VariableFont_wght.ttf" "${FILESDIR}/RobotoMono-Italic-VariableFont_wght.ttf" "${WORKDIR}/"
	default
}

