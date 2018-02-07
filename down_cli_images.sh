#!/bin/bash
# Download all known variations of CHIP images.
# Written by Jonathan A. Foster <jon@jfpossibilities.com>
# Started February 4th, 2018
#
# This script is provided free to be used however you see fit. There is
# absolutely no warranty of any kind.
#
# Requirements:
#     This script uses "wget" to pull down files.
#
# This is written to be non-destructive to its archive. New releases are
# downloaded beside the existing ones. Unfortunately I haven't found a way
# to determine what releases are available... short of trying from 1 to
# "latest". Their scripts refer to the release version as "CACHENUM".

### CONFIG ###

# These vars get pulled from "chip-update-firmware.sh" in the "CHIP-tools"
# Package: https://github.com/NextThingCo/CHIP-tools

DL_DIR=".dl"
DL_URL="http://opensource.nextthing.co/chip/images"
PROBES=(spl-40000-1000-100.bin
 spl-400000-4000-500.bin
 spl-400000-4000-680.bin
 sunxi-spl.bin
 u-boot-dtb.bin
 uboot-40000.bin
 uboot-400000.bin)
UBI_PREFIX="chip"
UBI_SUFFIX="ubi.sparse"

# These are harvested from "PROBES" and/or the "FORMAT" parsing in the script.
UBI_TYPES="40000-1000-100 400000-4000-500 400000-4000-680"

# These BUILDS are culled from the various "FLAVOR" selections in NTC's script.
# You can add others if you know about them.
BUILDS="server gui pocketchip buildroot"

# I only know of / or care about "stable". But you can put other branches
# you know of / care about here (separate with space):
BRANCHES="stable"



for branch in $BRANCHES; do
  for build in $BUILDS; do
    url="$DL_URL/$branch/$build"
    ver="`wget -O - -q $url/latest`"
    url="$url/$ver"
    dl="$DL_DIR/$branch-$build-b$ver"
    echo "$dl"
    mkdir -p "$dl"
    pushd "$dl" > /dev/null
      for file in ${PROBES[@]}; do
        wget -c "$url/$file"
      done
      for file in $UBI_TYPES; do
        wget -c "$url/$UBI_PREFIX-$file.$UBI_SUFFIX"
      done
    popd > /dev/null
  done
done
