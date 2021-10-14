#!/bin/bash
export ANDROID_SDK_ROOT=/android-sdk-linux

set -e
set -x

apt-get --quiet update --yes  
apt-get --quiet install --yes wget tar unzip libx11-6 libx11-dev lib32stdc++6 lib32z1 git --no-install-recommends  
apt-get --quiet install --yes libxcursor1 libasound2 libxcomposite1 libnss3 libgl1 libpulse0 libpulse-dev --no-install-recommends  

rm -rf /var/lib/apt/lists/* 

curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  
unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME}  
rm -rf gradle-${GRADLE_VERSION}-bin.zip  
curl -sSL "${ANDROID_SDK_URL}" -o android-sdk-linux.zip  
mkdir -p "$ANDROID_SDK_ROOT/cmdline-tools"
unzip android-sdk-linux.zip -d "$ANDROID_SDK_ROOT"/cmdline-tools
mv "$ANDROID_SDK_ROOT"/cmdline-tools/cmdline-tools "$ANDROID_SDK_ROOT"/cmdline-tools/latest
rm -rf android-sdk-linux.zip  
find "$ANDROID_HOME" -maxdepth 2  
mkdir $ANDROID_HOME/licenses  

set +e
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "tools" "platform-tools"
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "emulator"
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "platforms;${ANDROID_TARGET_SDK}"
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager --licenses

echo "Installed SDK"
