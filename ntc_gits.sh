#!/bin/bash
# Clone all known GIThub repos
# Written by Jonathan A. Foster <jon@jfpossibilities.com>
# Started February 4th, 2018
#
# This script is provided free to be used however you see fit. There is
# absolutely no warranty of any kind.
#
# Requirements:
#     git: to clone repos
#
# This script creates a "mirror" clone of all of the listed github porjects.
# These repositories are "bare" meaning you'll have to clone them again to
# checkout a working copy. But then you can edit the clone command below
# however you see fit.
#
# The list of repositories to clone is contained between the <<'EOF' and EOF
# markers below. You can edit to suit. List one repository per line. The
# github account they are hosted on is "hard coded" in the clone command. I
# pulled the list by going to their account page and copying and pasting the
# repository names. The list of available repositories could change at any
# time. Technically it would be possible to use an API call to get this
# list... but I'm not familiar with the github API.
while read s; do
  git clone --mirror "https://github.com/NextThingCo/$s.git" "$s.git"
done <<'EOF'
gadgetcli
Gadget-OS
chip-nand-scripts
RTL8723BS
CHIP-tools
chip-libsdl2
xf86-video-armsoc
rtl8723ds_bt
cdb
CHIP-linux
logrus-gadget-formatter
CHIP-u-boot
Dev_Kit-Hardware
CHIP_Pro-Hardware
gadget-buildroot
google-assistant-demo
CHIP-buildroot
wifi-onboarding
PocketCHIP-Education
PocketCHIP-pocket-home
linux
pocketchip-batt
gonnman
RTL8723DS
Gadget-Docker-Examples
CHIP-Hardware
CHIP-dt-overlays
CHIP-hwtest
chiptainer_python_io
chipcraft
DIPvendor
chiptainer_vu_meter
chiptainer_alpine
chippro-vu-meter
CHIP-SDK
dtc
chip-mali-userspace
pocketchip-keypad-patch
armhf-debootstrap
pocketchip-configs
CHIP-postchroot
chip-os-pro
Network-Interfaces-Script
chip-configs
rtl8723bs_bt
DIP-VGA-PCB
CHIP-mtd-utils
ioquake3-gles
chip-power
ahoy
pocketchip-load
chip-mali
freshmeshdemo
PocketCHIP-PCB
PockulusCHIP
pocketChip-keyboardPatch
MMA8451_Library
PocketCHIP-Mechanical
DIP-HDMI-PCB
Mega-PocketCHIP
pocketchip-onboard
pocketchip-localdoc
chip-exit
chip-theme
chip-metapackage
chip-input-reset
pocketchip-pcmanfm
pocketchip-leafpad
ChippyRuxpin
rocketchip
CHIP-boot-repair
sunxi-tools
libusb
libsoc
buildroot
otto-menu
otto-gif-mode
libOttoHardware
otto-network-setup
otto-runner
otto-utils
otto-creator
MegaCHIP-Hardware
nextthingco.github.io
OttDate
otto-gfx
otto-wifi-setup
rpi-buildroot
rtl81xxc
bx
bgfx
B.O.B.
drone
fbtft
meta-raspberrypi
EOF
