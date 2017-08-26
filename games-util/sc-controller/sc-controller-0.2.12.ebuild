# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A userspace driver and interface to the Steam Controller"
HOMEPAGE="https://github.com/kozec/sc-controller"
SRC_URI="https://github.com/kozec/sc-controller/archive/v${PV}.tar.gz -> ${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="daemon"

RDEPEND=">=x11-libs/gtk+-3.10:3
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/pygobject[${PYTHON_USEDEP}]
	dev-python/pylibacl[${PYTHON_USEDEP}]
	daemon? ( dev-python/pylibusb1 )"
DEPEND="${RDEPEND} dev-python/setuptools[${PYTHON_USEDEP}]"

RESTRICT="primaryuri"

pkg_postinst() {
	elog "Make sure that the kernel is compiled with the following options:"
	elog "Device Drivers --->"
	elog "Input device support --->"
	elog "[*] Miscellaneous devices --->"
	elog "<*> User level driver support"
	elog ""
	elog "Add the following udev rules to /etc/udev/rules.d/99-steam-controller-perms.rules"
	elog "if Steam was installed manually/from an overlay and ConsoleKit/systemd IS NOT being used:"
	elog "# Valve USB devices"
	elog "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"28de\", MODE=\"0666\""
	elog "# Steam Controller udev write access"
	elog "KERNEL==\"uinput\", SUBSYSTEM==\"misc\", MODE=\"0660\", GROUP=\"input\""
	elog "# HTC Vive HID Sensor naming and permissioning"
	elog "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{idVendor}==\"0bb4\", ATTRS{idProduct}==\"2c87\", MODE=\"0666\""
	elog ""
	elog "OR"
	elog ""
	elog "Add the following udev rules to /etc/udev/rules.d/99-steam-controller-perms.rules"
	elog "if Steam was installed manually/from an overlay and ConsoleKit/systemd IS being used:"
	elog "# Valve USB devices"
	elog "SUBSYSTEM==\"usb\", ATTRS{idVendor}==\"28de\", MODE=\"0666\""
	elog "# Steam Controller udev write access"
	elog "KERNEL==\"uinput\", SUBSYSTEM==\"misc\", TAG+=\"uaccess\", TAG+=\"udev-acl\""
	elog "# HTC Vive HID Sensor naming and permissioning"
	elog "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{idVendor}==\"0bb4\", ATTRS{idProduct}==\"2c87\", MODE=\"0666\""
	elog "Lastly, add acl to the USE variable to have an acl entry set for the logged in user"
	elog ""
	elog "Finally, reload the udev rules:"
	elog "udevadm control --reload"
	elog "udevadm trigger"
	elog ""
	elog "Some overlays install udev rules automatically"
	elog "Source: Gentoo Wiki: https://wiki.gentoo.org/wiki/Steam_Controller"
}
