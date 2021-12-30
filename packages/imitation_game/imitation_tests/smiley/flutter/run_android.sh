#!/bin/sh
# Copyright 2013 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

set -e
cd $( dirname "${BASH_SOURCE[0]}" )
source ../../../helper/run_android_helper.sh

readonly BUNDLE="com.example.smiley"
readonly TEST_NAME="smiley"

cd $( dirname "${BASH_SOURCE[0]}" )
cd smiley
flutter build apk
launch_apk ./build/app/outputs/flutter-apk/app-release.apk $BUNDLE "MainActivity"
sleep 10
MEMORY_TOTAL=`read_app_total_memory $BUNDLE`
report_results $TEST_NAME "flutter" "{\"adb_memory_total\":$MEMORY_TOTAL.0}"
