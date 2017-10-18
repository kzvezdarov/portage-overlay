# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="uinput driver and GTK3 GUI for Steam Controller"
HOMEPAGE="https://github.com/kozec/sc-controller"
SRC_URI="https://github.com/kozec/sc-controller/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
#IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-python/pycairo
	dev-python/pylibacl
	>=x11-libs/gtk+-3.10"
RDEPEND="${DEPEND}"

src_install() {
	distutils-r1_src_install

	# remove udev rules as we already cover these in steam-launcher
	rm "${D}"/usr/lib/udev/rules.d/90-sc-controller.rules
	rmdir "${D}"/usr/lib/udev/rules.d
	rmdir "${D}"/usr/lib/udev
}