#!/bin/bash

DIE() { LOG "SYNC FAILED : $*"; exit 1; }
LOG() { printf "$@\n\n"; }
TRY() { "$@" || DIE "$@"; }

# just in case
TRY cd $(dirname $0)"/../"

if [ ! -d .repo/local_manifests ]; then
  TRY repo init -u git://github.com/CyanogenMod/android.git -b cm-12.0
  TRY mkdir -p .repo/local_manifests
fi

TRY cp android/local_manifest.xml .repo/local_manifests/roomservice.xml
TRY repo sync -j40

