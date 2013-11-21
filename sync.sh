#!/bin/bash

DIE() { LOG "SYNC FAILED : $*"; exit 1; }
LOG() { printf "$@\n\n"; }
TRY() { "$@" || DIE "$@"; }

# just in case
TRY cd $(dirname $0)"/../"

which repo > /dev/null
if [ $? != 0 ]; then
  mkdir -p /usr/local/bin
  curl https://dl-ssl.google.com/dl/googlesource/git-repo/repo > /usr/local/bin/repo
  chmod a+x /usr/local/bin/repo
  # we're root (should be)
  exit
fi

if [ ! -d .repo/local_manifests ]; then
  TRY repo init -u git://github.com/CyanogenMod/android.git -b cm-11.0
  TRY mkdir -p .repo/local_manifests
fi

TRY cp android/local_manifest.xml .repo/local_manifests/roomservice.xml
TRY repo sync -j1

