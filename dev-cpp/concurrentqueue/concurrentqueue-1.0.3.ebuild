# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="A fast multi-producer, multi-consumer lock-free concurrent queue for C++11."
HOMEPAGE="https://github.com/cameron314/concurrentqueue"
EGIT_REPO_URI="https://github.com/cameron314/concurrentqueue"
EGIT_COMMIT="3747268264d0fa113e981658a99ceeae4dad05b7"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"

LICENSE="BSD-2"
SLOT="0"

DOCS=( LICENSE.md README.md )


