# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Music player"
HOMEPAGE="https://github.com/clangen/musikcube"
SRC_URI="https://github.com/clangen/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="
	dev-libs/boost:0
	net-misc/curl:0
	net-libs/libmicrohttpd:0
	media-libs/libogg:0
	media-libs/libvorbis:0
	media-libs/flac:0
	media-libs/faad2:0
	media-libs/alsa-lib:0
	media-sound/pulseaudio:0
	media-sound/lame:0
	sys-libs/ncurses:0
	sys-libs/zlib:0
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig"

CMAKE_IN_SOURCE_BUILD=True

src_prepare() {
  cmake-utils_src_prepare
}

src_configure() {
  cmake-utils_src_configure
}

src_install() {
  cmake-utils_src_install
}