#!/bin/bash

set -e
set -x

apt-get --quiet update --yes  
apt-get --quiet install --yes wget tar unzip lib32stdc++6 lib32z1 git --no-install-recommends  
rm -rf /var/lib/apt/lists/* 

curl -sSL "${GRADLE_SDK_URL}" -o gradle-${GRADLE_VERSION}-bin.zip  
unzip gradle-${GRADLE_VERSION}-bin.zip -d ${SDK_HOME}  
rm -rf gradle-${GRADLE_VERSION}-bin.zip  
curl -sSL "${ANDROID_SDK_URL}" -o android-sdk-linux.zip  
unzip android-sdk-linux.zip -d android-sdk-linux  
rm -rf android-sdk-linux.zip  
find "$ANDROID_HOME" -maxdepth 2  
mkdir $ANDROID_HOME/licenses  

set +e
yes | $ANDROID_HOME/tools/bin/sdkmanager "tools" "platform-tools"
yes | $ANDROID_HOME/tools/bin/sdkmanager "emulator"
yes | $ANDROID_HOME/tools/bin/sdkmanager "build-tools;${ANDROID_BUILD_TOOLS}"
yes | $ANDROID_HOME/tools/bin/sdkmanager "platforms;android-${ANDROID_TARGET_SDK}"
yes | $ANDROID_HOME/tools/bin/sdkmanager "${ANDROID_IMAGES}"
yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses

echo "Installed SDK"
