#!/bin/bash
#
# Copyright (C) 2018-2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

set -e

DEVICE_COMMON=chagall-common
VENDOR=samsung

# Load extractutils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

HELPER="${ANDROID_ROOT}/tools/extract-utils/extract_utils.sh"
if [ ! -f "${HELPER}" ]; then
    echo "Unable to find helper script at ${HELPER}"
    exit 1
fi
source "${HELPER}"

# Default to sanitizing the vendor folder before extraction
CLEAN_VENDOR=true

KANG=
SECTION=

while [ "${#}" -gt 0 ]; do
    case "${1}" in
        -n | --no-cleanup )
                CLEAN_VENDOR=false
                ;;
        -k | --kang )
                KANG="--kang"
                ;;
        -s | --section )
                SECTION="${2}"; shift
                CLEAN_VENDOR=false
                ;;
        * )
                SRC="${1}"
                ;;
    esac
    shift
done

if [ -z "${SRC}" ]; then
    SRC="adb"
fi

# Initialize the helper
setup_vendor "${DEVICE_COMMON}" "${VENDOR}" "${ANDROID_ROOT}" true "${CLEAN_VENDOR}"

extract "${MY_DIR}/proprietary-files.txt" "${SRC}" "${KANG}" --section "${SECTION}"

# Fix proprietary blobs
BLOB_ROOT="$LINEAGE_ROOT"/vendor/"$VENDOR"/"$DEVICE_COMMON"/proprietary

# nvram_mfg.txt
sed -i 's|ccode=ALL|ccode=00|g' $BLOB_ROOT/etc/wifi/nvram_mfg.txt_4354_a0
sed -i 's|regrev=0|regrev=6|g' $BLOB_ROOT/etc/wifi/nvram_mfg.txt_4354_a0
sed -i 's|ccode=ALL|ccode=00|g' $BLOB_ROOT/etc/wifi/nvram_mfg.txt_4354_a1
sed -i 's|regrev=0|regrev=6|g' $BLOB_ROOT/etc/wifi/nvram_mfg.txt_4354_a1

# nvram_net.txt
sed -i 's|ccode=GB|ccode=00|g' $BLOB_ROOT/etc/wifi/nvram_net.txt_4354_a0
sed -i 's|ccode=GB|ccode=00|g' $BLOB_ROOT/etc/wifi/nvram_net.txt_4354_a1

"${MY_DIR}/setup-makefiles.sh"
