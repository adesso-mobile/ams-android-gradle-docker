#!/bin/bash
set -e

cd /opt/workspace

if [ -n "$USE_EMULATOR" ]; then
    if [ -z "$ANDROID_SYSTEM_IMG" ]; then
        export ANDROID_SYSTEM_IMG="system-images;android-27;google_apis;x86"
    fi
    /android-sdk-linux/tools/bin/sdkmanager "$ANDROID_SYSTEM_IMG"
    /android-sdk-linux/tools/bin/avdmanager create avd --force --name espresso -d 33 -k "$ANDROID_SYSTEM_IMG"

    test -f ~/.android/avd/espresso.avd/config.ini || { echo "No Espresso AVD Config file" && exit 1; }
    echo "disk.dataPartition.size=1024m" >> ~/.android/avd/espresso.avd/config.ini
    echo "hw.ramSize=1024" >> ~/.android/avd/espresso.avd/config.ini

    /android-sdk-linux/emulator/emulator -avd espresso -no-skin -no-window -no-boot-anim -skip-adb-auth -writable-system & /android-sdk-linux/platform-tools/adb wait-for-device
fi

"$(pwd)"/gradlew $GRADLE_TASKS
