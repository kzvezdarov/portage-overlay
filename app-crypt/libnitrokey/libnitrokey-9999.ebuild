# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Nitrokey Pro and Storage communication API"
HOMEPAGE="https://github.com/Nitrokey/libnitrokey"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
  EGIT_CLONE_TYPE="shallow"
	EGIT_REPO_URI="https://github.com/Nitrokey/libnitrokey"
else
	SRC_URI="https://github.com/Nitrokey/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
virtual/libusb:1
dev-libs/hidapi:0"

src_prepare() {
  eapply "${FILESDIR}/${PN}-static-install.patch"
  cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLIBNITROKEY_STATIC=ON
	)
	cmake-utils_src_configure
}
